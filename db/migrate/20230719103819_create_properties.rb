class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :landlord, null: false, foreign_key: { to_table: :users }
      t.string :address
      t.decimal :rent_amount
      t.string :property_type
      t.text :description

      t.timestamps
    end
  end
end
