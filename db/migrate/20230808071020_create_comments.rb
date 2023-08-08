class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true
      t.text :content
      t.datetime :created_at
    end
  end
end
