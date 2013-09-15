class City < ActiveRecord::Base
  attr_accessible :name, :state_id, :q_state_center, :lat, :lon

  belongs_to :state
  has_many :addresses

  scope :select_ready, select('id AS city_id, name, state_id, lat, lon').order('name')
end
