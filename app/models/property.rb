class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'

  validates :property_name, presence: true
  validates :address, presence: true
  validates :rent_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :property_type, presence: true

  has_many_attached :images
end
