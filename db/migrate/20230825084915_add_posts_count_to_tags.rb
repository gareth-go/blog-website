class AddPostsCountToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :posts_count, :integer
  end
end
