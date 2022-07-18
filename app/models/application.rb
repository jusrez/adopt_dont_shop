class Application < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :description
  validates :state, length: { maximum: 2 }
  validates :zip_code, numericality: true, length: { maximum: 5 }
  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
