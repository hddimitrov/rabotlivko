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

  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    puts '================================================='
    puts auth.credentials.inspect
    puts '-------------------------------------------------'
    puts auth.info
    puts '-------------------------------------------------'
    puts auth.info.name
    puts '================================================='

    if user.blank?
      user = User.new
      user.name = auth.info.name,
      user.provider = auth.provider,
      user.uid = auth.uid,
      user.email =  auth.info.email,
      user.fb_token = auth.credentials.token

      user.skip_confirmation!

      user.save(validate: false)
    end

    user
  end
end
