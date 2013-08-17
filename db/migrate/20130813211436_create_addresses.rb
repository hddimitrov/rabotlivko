class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.integer :state_id
      t.integer :city_id
      t.string :line

      t.timestamps
    end
    add_index :addresses, :addressable_id
  end
end
