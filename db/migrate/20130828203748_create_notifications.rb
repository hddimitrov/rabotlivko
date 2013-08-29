class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :q_notified
      t.string :notifiable_type
      t.integer :notifiable_id
      t.string :notifiable_cache
      t.string :action
      t.string :key

      t.timestamps
    end

    add_index :notifications, :user_id
  end
end
