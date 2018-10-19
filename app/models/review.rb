class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy

  validates_presence_of :rating, :user_id, :book_id
  validates :title, length: { maximum: 50 }
  validates :body, length: { maximum: 1000 }
  validates :rating, numericality: { only_integer: true, greater_than: 0,
    less_than_or_equal_to: 10 }
  validates :user_id, numericality: { only_integer: true }
  validates :book_id, numericality: { only_integer: true }
  validates_uniqueness_of :book, scope: :user,
    message: "can be reviewed only once by each user"

  def net_upvotes
    net = 0
    votes.each do |vote|
      net = vote.upvote ? net + 1 : net - 1
    end
    return net
  end

  def time_diff
    Time.zone.now - created_at #in seconds
  end

  def display_time
    if time_diff < 60 #1 min
      time = "less than 1m ago"
    elsif time_diff < 3600 #1 hr
      time = "#{(time_diff / 60).round}m ago"
    elsif time_diff < 86400 #1 day
      time = "#{(time_diff / 3600).round}h ago"
    else
      time = "#{(time_diff / 86400).round}d ago"
    end
    return time
  end

  def user_vote(current_user)
    votes.find_by(user: current_user) || Vote.new
  end
end
