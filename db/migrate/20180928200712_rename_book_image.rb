class RenameBookImage < ActiveRecord::Migration[5.2]
  def up
    rename_column :books, :image_url, :image
  end

  def down
    rename_column :books, :image, :image_url
  end
end
