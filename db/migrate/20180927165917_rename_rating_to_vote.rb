class RenameRatingToVote < ActiveRecord::Migration[5.2]
  def change
    rename_table :ratings, :votes
  end
end
