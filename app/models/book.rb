class YearValidator < ActiveModel::Validator
  def validate(record)
    if record.year.to_i > Time.zone.today.year
      record.errors[:base] << "Publication year cannot be in the future"
    end
  end
end

class Book < ApplicationRecord
  GENRES = ["Drama", "Mystery", "Romance", "Fantasy", "SciFi", "Non-Fiction"]

  belongs_to :user
  belongs_to :author
  accepts_nested_attributes_for :author
  has_many :reviews, dependent: :destroy

  validates_presence_of :title, :author, :user_id
  validates :user_id, numericality: { only_integer: true }
  validates :genre, inclusion: { in: GENRES }
  validates :synopsis, length: { maximum: 1000 }
  validates :year, length: { is: 4 }, numericality: { only_integer: true },
    allow_nil: true
  validates_with YearValidator
  # validates_processing_of :image
  # validates_integrity_of :image
  validate :image_size_validation

  mount_uploader :image, ImageUploader

  def self.search(search)
    Book.where("books.title ILIKE ? OR books.synopsis ILIKE ?", "%#{search}%", "%#{search}%")
  end

  private

  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end
end
