class Rating < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates_presence_of :upvote, :user_id, :review_id
  validates :user_id, numericality: { only_integer: true }
  validates :review_id, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: :review_id,
    message: "Each user can rate a review only once" }
end
