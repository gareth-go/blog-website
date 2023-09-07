class AddReactionsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :reactions_count, :integer
  end
end
