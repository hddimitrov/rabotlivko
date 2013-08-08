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
    info = auth.info

    puts '================================================='
    puts auth.credentials.inspect
    puts '-------------------------------------------------'
    puts info.inspect
    puts '-------------------------------------------------'
    puts info['name'].inspect
    puts info['email'].inspect
    puts '================================================='

    if user.blank?
      user = User.new
      
      user.provider = auth.provider
      user.uid = auth.uid
      user.fb_token = auth.credentials.token

      user.name = info['name']
      user.email =  info['email']

      user.skip_confirmation!

      user.save(validate: false)
    end

    user
  end
end
