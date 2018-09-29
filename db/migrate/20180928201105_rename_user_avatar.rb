class RenameUserAvatar < ActiveRecord::Migration[5.2]
  def up
    rename_column :users, :avatar_url, :avatar
  end

  def down
    rename_column :users, :avatar, :avatar_url
  end
end
