class QDraftDefaultFalse < ActiveRecord::Migration
  def change
    change_column :adverts, :q_draft, :boolean, default: false
    change_column :want_ads, :q_draft, :boolean, default: false
  end
end
