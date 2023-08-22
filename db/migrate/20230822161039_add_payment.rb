class AddPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :payment_reference, :string
    add_column :rentals, :payment_date, :datetime
    add_column :rentals, :payment_status, :string
    add_column :rentals, :payment_amount, :decimal
    change_column :rooms, :rental_status, :string, default: 'Available'
    remove_column :rooms, :payment_amount
    remove_column :rooms, :payment_date
    remove_column :rooms, :payment_status
  end
end
