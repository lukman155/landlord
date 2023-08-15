class Room < ApplicationRecord
  belongs_to :property

  validate :validate_max_number_of_rooms, on: :create
  validates :room_number, uniqueness: { scope: :property_id, message: 'must be unique within the property' }
  
  private

  def validate_max_number_of_rooms
    if property.rooms.count >= 64
      errors.add(:base, 'Maximum number of rooms (64) has been reached for this property.')
    end
  end
end