# app/controllers/rentals_controller.rb
class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = current_user.rentals
  end

  def show
    @rental = Rental.includes(:room).find(params[:id])
  end

  
  
  def rental_params
    params.require(:rental).permit(:renter_id, :room_number, :rent_amount, :rent_date, :rent_duration)
  end

end