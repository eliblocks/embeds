class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.string :paypal_email
      t.integer :balance, default: 6000

      t.timestamps
    end
  end
end
