class AddDefaultValueForCounter < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :comments_count, from: nil, to: 0
    change_column_default :posts, :reactions_count, from: nil, to: 0
  end
end
