class AddAuthor < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name
      t.string :suffix

      t.timestamps null: false
    end
  end
end
