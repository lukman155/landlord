# app/controllers/rooms_controller.rb

class RoomsController < ApplicationController
  def index
    @property = Property.find(params[:property_id])
    @rooms = @property.rooms
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @property = Property.find(params[:property_id])
    @room = @property.rooms.build
  end

  def create
    @property = Property.find(params[:property_id])
    @room = @property.rooms.build(room_params)

    if @room.save
      redirect_to property_path(@property), notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])

    if @room.update(room_params)
      redirect_to property_path(@room.property), notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    property = @room.property

    @room.destroy
    redirect_to property_path(property), notice: 'Room was successfully deleted.'
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :rent_amount, :room_type)
  end
end
