class AddCommentsAndPostsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :comments_count, :integer
    add_column :users, :posts_count, :integer
  end
end
