class RoomsController < ApplicationController
  def new
    property = Property.find(params[:property_id])
    room_count = params[:room_count].to_i

    room_count.times do
      property.rooms.create(room_number: room_count, rent_amount: property.rent_amount)
    end

    redirect_to property_path(property), notice: "#{room_count} rooms were successfully created."
  end
end
