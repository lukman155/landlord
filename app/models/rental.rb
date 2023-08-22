class Rental < ApplicationRecord
  belongs_to :room
  belongs_to :renter, class_name: 'User'

  validates :renter_id, :room_id, :rent_date, :rent_duration, presence: true

  def remaining_rent_duration
    days_left = rent_duration - (Date.today - rent_date).to_i
    days_left > 0 ? days_left : 0
  end

  def rent_payment_due
    rent_amount * rent_duration
  end
end