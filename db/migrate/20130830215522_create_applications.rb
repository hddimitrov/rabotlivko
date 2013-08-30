class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :applicable_type
      t.integer :applicable_id
      t.integer :applicant_id
      t.string :owner_status
      t.string :applicant_status

      t.timestamps
    end

    add_index :applications, :applicable_id
    add_index :applications, :applicant_id
  end
end
