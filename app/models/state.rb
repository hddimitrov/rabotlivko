class State < ActiveRecord::Base
  attr_accessible :name, :lat, :kon

  has_many :cities
end
