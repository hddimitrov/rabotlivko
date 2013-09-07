class AddSlugFields < ActiveRecord::Migration
  def up
    add_column :users, :slug, :string
    add_column :adverts, :slug, :string
    add_column :want_ads, :slug, :string
    add_index :users, :slug, unique: true
    add_index :adverts, :slug, unique: true
    add_index :want_ads, :slug, unique: true
  end

  def down
    remove_column :users, :slug
    remove_column :adverts, :slug
    remove_column :want_ads, :slug
    remove_index :users, :slug
    remove_index :adverts, :slug
    remove_index :want_ads, :slug
  end
end
