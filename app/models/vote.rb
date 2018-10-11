class Vote < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates_presence_of :user_id, :review_id
  validates_inclusion_of :upvote, in: [true, false]
  validates :user_id, numericality: { only_integer: true }
  validates :review_id, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: :review_id,
    message: "Each user can vote on a review only once" }

  def self.update_or_destroy(user, review, upvote)
    previous_vote = Vote.find_by(review: review, user: user)
    if previous_vote.nil?
      Vote.create(review: review, user: user, upvote: upvote)
    elsif previous_vote.upvote.to_s == upvote
      previous_vote.destroy
    else
      previous_vote.update_attributes(upvote: upvote)
    end
  end
end
