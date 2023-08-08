class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :cover_image
      t.datetime :created_at
      t.references :user, foreign_key: true
      t.integer :status
    end
  end
end
