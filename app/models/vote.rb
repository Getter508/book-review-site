class Vote < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates_presence_of :user_id, :review_id
  validates_inclusion_of :upvote, in: [true, false]
  validates :user_id, numericality: { only_integer: true }
  validates :review_id, numericality: { only_integer: true }
  validates_uniqueness_of :user, scope: :review

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

  def set_div_class(current_user, value)
    klass = value ? 'up' : 'down'
    if current_user == user && upvote == value
      return "#{klass} callout small warning"
    else
      return "#{klass} callout small"
    end
  end
end
