# app/controllers/rentals_controller.rb
class RentalsController < ApplicationController

  
  
  def rental_params
    params.require(:rental).permit(:renter_id, :room_number, :rent_amount, :rent_date, :rent_duration)
  end

end