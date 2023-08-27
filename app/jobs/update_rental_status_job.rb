class UpdateRentalStatusJob < ApplicationJob
  queue_as :default

  def perform
    rentals_to_update = Rental.where("rent_date <= ?", Date.current)
    
    rentals_to_update.each do |rental|
      room = rental.room
      room.update(rental_status: "Available", payment_reference: "")
    end
  end
end
