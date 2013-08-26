class CreateContractorCategories < ActiveRecord::Migration
  def up
    add_column :users, :q_contractor, :boolean, default: false
    create_table :contractor_categories, :id => false do |t|
      t.integer :contractor_id
      t.integer :category_id

      t.timestamps
    end

    add_index :contractor_categories, :contractor_id
    add_index :contractor_categories, :category_id
  end

  def down
    remove_column :users, :q_contractor
    drop_table :contractor_categories
  end
end
