class AddPriceFlagsToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :q_price_free,       :boolean, default: false
    add_column :adverts, :q_price_negotiable, :boolean, default: false
    rename_column :adverts, :draft, :q_draft
  end
end
