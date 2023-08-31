class AddPaymentReferenceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :payment_reference, :string
  end
end
