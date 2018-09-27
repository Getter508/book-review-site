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
end
