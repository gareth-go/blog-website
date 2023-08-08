class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :reaction_type
      t.datetime :created_at
    end

    add_index :reactions, [:user_id, :post_id], unique: true
  end
end
