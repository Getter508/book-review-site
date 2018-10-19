class AddReviewIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :reviews, [:user_id, :book_id], unique: true
  end
end
