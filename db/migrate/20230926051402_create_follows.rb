class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :follower, foreign_key: { to_table: :users }
    end

    add_index :follows, [:user_id, :follower_id], unique: true

    add_column :users, :follows_count, :integer
    add_column :users, :followings_count, :integer
  end
end
