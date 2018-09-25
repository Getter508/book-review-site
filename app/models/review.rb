class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :ratings

  validates_presence_of :title, :body, :user_id, :book_id
  validates :title, length: { maximum: 50 }
  validates :body, length: { maximum: 1000 }
  validates :user_id, numericality: { only_integer: true }
  validates :book_id, numericality: { only_integer: true }
end
