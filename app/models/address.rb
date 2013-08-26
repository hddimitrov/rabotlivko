class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  attr_accessible :city_id, :line, :state_id

  belongs_to :state
  belongs_to :city
end
