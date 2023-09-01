class Room < ApplicationRecord
  belongs_to :property

  has_one :rental

  validate :validate_max_number_of_rooms, on: :create
  validates :room_number, uniqueness: { scope: :property_id, message: 'must be unique within the property' }
  
  attr_accessor :number_of_rooms


  def self.available_count_by_type(room_type)
    where(room_type: room_type, rental_status: 'Available').count
  end

  private

  def validate_max_number_of_rooms
    if property.rooms.count >= 64
      errors.add(:base, 'Maximum number of rooms (64) has been reached for this property.')
    end
  end
end