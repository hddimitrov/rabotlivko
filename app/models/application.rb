class Application < ActiveRecord::Base
  attr_accessible :applicable_id, :applicable_type, :applicant_id, :applicant_status, :owner_status

  belongs_to :applicable, polymorphic: true
  belongs_to :applicant, class_name: 'User', foreign_key: :applicant_id
end
