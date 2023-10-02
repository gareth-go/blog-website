class CreateBookMarks < ActiveRecord::Migration[6.1]
  def change
    create_table :book_marks do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
    end

    add_index :book_marks, [:user_id, :post_id], unique: true
  end
end
