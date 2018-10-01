class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username
  validates :username, length: { in: 5..15 }, format: { with: /[a-zA-Z0-9]/ }
  # validates_processing_of :avatar
  # validates_integrity_of :avatar
  validate :avatar_size_validation

  mount_uploader :avatar, ImageUploader

  def display_name
    "#{last_name}, #{first_name}"
  end

  private

  def avatar_size_validation
    errors[:image] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
