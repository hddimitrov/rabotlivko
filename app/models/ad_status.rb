class AdStatus < ActiveRecord::Base
  attr_accessible :name

  has_many :adverts
  has_many :want_ads
end
