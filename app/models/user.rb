class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_name, use: :slugged
  attr_accessor :slug_name

  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
                  :uid, :provider, :fb_token, :attachments_attributes, :address_attributes, :q_contractor

  has_many :adverts, dependent: :delete_all
  has_many :want_ads, dependent: :delete_all

  has_many :contractor_categories, foreign_key: :contractor_id, dependent: :delete_all
  has_many :applications, foreign_key: :applicant_id, dependent: :delete_all

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :attachments, as: :attachable, dependent: :delete_all
  accepts_nested_attributes_for :attachments, allow_destroy: true


  scope :today,       lambda { where('created_at > ?', Time.now.beginning_of_day) }
  scope :yesterday,   lambda { where('created_at < ? AND created_at > ?', 1.day.ago.end_of_day, 1.day.ago.beginning_of_day) }
  scope :this_month,  lambda { where('created_at > ?', Time.now.beginning_of_month) }
  scope :last_month,  lambda { where('created_at < ? AND created_at > ?', 1.month.ago.end_of_month, 1.month.ago.beginning_of_month) }
  scope :this_year,   lambda { where('created_at > ?', Time.now.beginning_of_year) }
  scope :beginning,   lambda { where('id > 0')}

  acts_as_marker
  markable_as [ :favorite, :blocked, :followed ]

  acts_as_messageable required: :body, dependent: :destroy

  def slug_name
    self.name.to_slug.transliterate(:bulgarian).to_s
  end

  def update_slug
    composite_slug = (self.name || '').to_slug.transliterate(:bulgarian).to_s
    self.slug_name = composite_slug
  end

  def self.find_for_facebook_oauth(auth)
    info = auth.info

    user = User.find_by_email(info['email'])

    if user.present?
      user.uid = auth.uid
      user.provider = auth.provider
      user.fb_token = auth.credentials.token
    else
      user = User.new
      user.name = info['name'].to_s.gsub(/[^[:alpha:] .-]+/, '')
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
