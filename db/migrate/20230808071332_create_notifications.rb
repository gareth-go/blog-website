class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :notificationable, polymorphic: true
      t.text :content
    end
  end
end
