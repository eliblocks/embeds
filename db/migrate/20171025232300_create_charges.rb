class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.string :gateway_charge_id
      t.integer :amount
      t.integer :amount_refunded
      t.string :balance_transaction
      t.boolean :captured
      t.integer :created
      t.string :currency
      t.string :description
      t.boolean :success
      t.references :user, foreign_key: true
      t.integer :seconds

      t.timestamps
    end
  end
end
