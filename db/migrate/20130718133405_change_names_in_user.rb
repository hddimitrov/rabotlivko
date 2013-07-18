class ChangeNamesInUser < ActiveRecord::Migration
  def up
  	change_column :users, :first_name, :name
  	remove_column :users, :last_name
  end

  def down
  	change_column :users, :name, :first_name
  	add_column :users, :last_name, :string
  end
end
