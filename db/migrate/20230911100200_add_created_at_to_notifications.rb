class AddCreatedAtToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :created_at, :datetime
  end
end
