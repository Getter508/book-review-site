require 'date'

class YearValidator < ActiveModel::Validator
  def validate(record)
    if record.year.to_i > Date.today.year
      record.errors[:base] << "Publication year cannot be in the future"
    end
  end
end

class Book < ApplicationRecord
  GENRES = ["Drama", "Mystery", "Romance", "Fantasy", "SciFi", "Non-Fiction"]

  belongs_to :user
  has_many :reviews

  validates_presence_of :title, :author, :user_id
  validates :user_id, numericality: { only_integer: true }
  validates :genre, inclusion: { in: GENRES }
  validates :synopsis, length: { maximum: 500 }
  validates :year, length: { is: 4 }, numericality: { only_integer: true },
    allow_nil: true
  validates_with YearValidator
end
