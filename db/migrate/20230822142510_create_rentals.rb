class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :room, null: false, foreign_key: true
      t.references :renter, null: false, foreign_key: { to_table: :users }
      t.date :rent_date
      t.integer :rent_duration

      t.timestamps
    end
  end
end
