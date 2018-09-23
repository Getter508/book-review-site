class AddUserNamesRolesAvatars < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :avatar_url, :string
  end
end
