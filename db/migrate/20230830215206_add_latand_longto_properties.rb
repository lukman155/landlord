class AddLatandLongtoProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :latitude, :float
    add_column :properties, :longitude, :float
    rename_column :properties, :address, :street
  end
end
