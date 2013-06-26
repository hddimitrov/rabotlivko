class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :category_id
      t.float :price
      t.boolean :draft

      t.timestamps
    end
  end
end
