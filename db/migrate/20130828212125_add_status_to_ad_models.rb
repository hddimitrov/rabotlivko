class AddStatusToAdModels < ActiveRecord::Migration
  def change
    remove_column :want_ads, :q_draft
    remove_column :adverts, :q_draft
    add_column :want_ads, :ad_status_id, :integer
    add_column :adverts, :ad_status_id, :integer
    add_column :adverts, :published_at, :date
  end
end
