class RemoveBookAuthorAndUpdateAuthorId < ActiveRecord::Migration[5.2]
  def up
    remove_column :books, :author, :string, null: false
    change_column :books, :author_id, :integer, null: false
  end

  def down
    add_column :books, :author, :string
    change_column :books, :author_id, :integer
  end
end
