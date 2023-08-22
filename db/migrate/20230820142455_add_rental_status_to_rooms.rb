class AddRentalStatusToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :rental_status, :string
    add_column :properties, :city, :string
    add_column :properties, :state, :string
    add_column :properties, :area, :string

  end
end
