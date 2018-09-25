class AddReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :user_id, null: false
      t.integer :book_id, null: false

      t.timestamps null: false
    end
  end
end
