class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :property, null: false, foreign_key: true
      t.integer :room_number
      t.decimal :rent_amount
      t.string :payment_status
      t.string :payment_reference
      t.decimal :payment_amount
      t.datetime :payment_date
      t.string :room_type

      t.timestamps
    end
  end
end
