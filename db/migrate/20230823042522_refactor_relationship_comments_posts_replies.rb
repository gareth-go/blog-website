class RefactorRelationshipCommentsPostsReplies < ActiveRecord::Migration[6.1]
  def change
    change_table :comments do |t|
      t.remove :commentable_type, :commentable_id
      t.references :post, foreign_key: true
      t.references :parent_comment, foreign_key: { to_table: :comments }
    end
  end
end
