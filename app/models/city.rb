class City < ActiveRecord::Base
  attr_accessible :name, :state_id, :q_state_center, :lat, :lon

  belongs_to :state
end
