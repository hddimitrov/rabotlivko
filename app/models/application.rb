class Application < ActiveRecord::Base
  attr_accessible :applicable_id, :applicable_type, :applicant_id, :applicant_type, :applicant_status, :owner_status

  belongs_to :applicable, polymorphic: true
  belongs_to :applicant, polymorphic: true
end
