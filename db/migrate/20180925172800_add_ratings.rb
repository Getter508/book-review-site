class AddRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.boolean :upvote, null: false
      t.integer :user_id, null: false
      t.integer :review_id, null: false

      t.timestamps null: false
    end

    add_index :ratings, [:user_id, :review_id], unique: true
  end
end
