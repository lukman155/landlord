class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'

  attr_accessor :number_of_rooms
  attr_accessor :room_type
  has_many :rooms, dependent: :destroy
  accepts_nested_attributes_for :rooms, allow_destroy: true

  validates :property_name, presence: true
  validates :address, presence: true
  validates :rent_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :property_type, presence: true

  has_many_attached :images

  def room_options
    @all_rooms_by_type ||= rooms.group_by(&:room_type)
    @all_rooms_by_type.keys.size
  end
end
