class ModifyReviewTitleAndBody < ActiveRecord::Migration[5.2]
  def up
    remove_column :reviews, :title, :string, null: false
    remove_column :reviews, :body, :string, null: false
    add_column :reviews, :title, :string
    add_column :reviews, :body, :string
  end

  def down
    remove_column :reviews, :title, :string
    remove_column :reviews, :body, :string
    add_column :reviews, :title, :string, null: false
    add_column :reviews, :body, :string, null: false
  end
end
