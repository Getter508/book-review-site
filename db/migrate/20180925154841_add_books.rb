class AddBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :year
      t.string :genre
      t.string :synopsis
      t.string :image_url
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
