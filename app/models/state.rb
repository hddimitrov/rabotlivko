class State < ActiveRecord::Base
  attr_accessible :name, :lat, :kon

  has_many :cities
  has_many :addresses

  scope :select_ready, select('id AS state_id, name, lat, lon').order('name')
end
