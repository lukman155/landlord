class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'

  attr_accessor :number_of_rooms
  attr_accessor :room_type
  attr_accessor :rooms_attributes

  has_many :rooms, dependent: :destroy
  accepts_nested_attributes_for :rooms, allow_destroy: true

  validates :property_name, presence: true
  validates :rent_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many_attached :images

  def room_options
    @all_rooms_by_type ||= rooms.group_by(&:room_type)
    @all_rooms_by_type.keys.size
  end

  def available_rooms_count_by_type(room_type)
    rooms.where(room_type: room_type).available_count_by_type(room_type)
  end

  def full_address 
    [area, city].compact.join(", ")
  end
end
