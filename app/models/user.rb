class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
                  :uid, :provider, :fb_token

  has_many :adverts
  has_many :want_ads

  scope :today,       lambda { where('created_at > ?', Time.now.beginning_of_day) }
  scope :yesterday,   lambda { where('created_at < ? AND created_at > ?', 1.day.ago.end_of_day, 1.day.ago.beginning_of_day) }
  scope :this_month,  lambda { where('created_at > ?', Time.now.beginning_of_month) }
  scope :last_month,  lambda { where('created_at < ? AND created_at > ?', 1.month.ago.end_of_month, 1.month.ago.beginning_of_month) }
  scope :this_year,   lambda { where('created_at > ?', Time.now.beginning_of_year) }
  scope :beginning,   lambda { where('id > 0')}

  def self.find_for_facebook_oauth(auth)
    info = auth.info

    user = User.find_by_email(info['email'])

    if user.present?
      user.uid = auth.uid
      user.provider = auth.provider
      user.fb_token = auth.credentials.token
    else
      user = User.new
      user.name = info['name']
      user.email = info['email']
      user.uid = auth.uid
      user.provider = auth.provider
      user.fb_token = auth.credentials.token
      user.skip_confirmation!
    end

    user.save(validate: false)

    user
  end
end
