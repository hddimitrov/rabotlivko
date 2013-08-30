class Category < ActiveRecord::Base
  attr_accessible :title
  has_many :adverts
  has_many :want_ads
  has_many :contractor_categories
end
