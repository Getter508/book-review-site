class Author < ApplicationRecord
  has_many :books

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{middle_name} #{last_name} #{suffix}"
  end

  # def middle_initial
  #   middle_name.first
  # end

  def self.search(search)
    Author.where("concat(first_name, ' ', last_name) ILIKE ?
    OR concat(first_name, ' ', last_name, ' ', suffix) ILIKE ?
      OR concat(first_name, ' ', middle_name, ' ', last_name) ILIKE ?
      OR concat(first_name, ' ', middle_name, ' ', last_name, ' ', suffix) ILIKE ?
      OR concat(first_name, ' ', LEFT(middle_name, 1), ' ', last_name) ILIKE ?
      OR concat(first_name, ' ', LEFT(middle_name, 1), ' ', last_name, ' ', suffix) ILIKE ?
      OR concat(first_name, ' ', LEFT(middle_name, 1), '. ', last_name) ILIKE ?
      OR concat(first_name, ' ', LEFT(middle_name, 1), '. ', last_name, ' ', suffix) ILIKE ?
      OR first_name ILIKE ?
      OR middle_name ILIKE ?
      OR last_name ILIKE ?",
      "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%",
      "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%",
      "%#{search}%")
  end
end
