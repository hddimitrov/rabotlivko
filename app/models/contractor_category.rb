class ContractorCategory < ActiveRecord::Base
  attr_accessible :contractor_id, :category_id

  belongs_to :contractor
  belongs_to :category
end
