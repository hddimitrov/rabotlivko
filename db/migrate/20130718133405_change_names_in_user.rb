class ChangeNamesInUser < ActiveRecord::Migration
  def up
  	rename_column :users, :first_name, :name
  	remove_column :users, :last_name
  end

  def down
  	rename_column :users, :name, :first_name
  	add_column :users, :last_name, :string
  end
end
