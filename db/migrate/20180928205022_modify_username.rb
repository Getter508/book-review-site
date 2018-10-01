class ModifyUsername < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :username, :string, null: false, unique: true
  end

  def down
    change_column :users, :username, :string
  end
end
