class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /properties or /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1 or /properties/1.json
  def show
    @property = Property.includes(:rooms).find(params[:id])
    @rooms = @property.rooms
    @rooms_by_type = @rooms.group(:room_type).select("room_type, COUNT(*) as count, MIN(rent_amount) as rent_amount")
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end
  
  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        create_rooms(
          @property.number_of_rooms.to_i,
          @property.rent_amount.to_f,
          @property.room_type
        )
        format.html { redirect_to property_url(@property), notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_url(@property), notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def create_rooms(number_of_rooms, rent_amount, room_type)
      number_of_rooms.times do |index|
        @property.rooms.create(
          rent_amount: rent_amount,
          room_type: room_type,
          room_number: index + 1
        )
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:landlord_id, :address, :rent_amount, :property_type, :description, :property_name, :number_of_rooms, :room_type, :number_of_rooms )
    end
end
