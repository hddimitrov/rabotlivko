class CreateWantAds < ActiveRecord::Migration
  def change
    create_table :want_ads do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :description
      t.string :price
      t.boolean :q_price_free, default: false
      t.boolean :q_price_negotiable, default: false
      t.date :deadline
      t.boolean :q_draft

      t.timestamps
    end
  end
end
