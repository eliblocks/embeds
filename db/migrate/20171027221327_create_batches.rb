class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.string :paypal_id
      t.integer :amount
      t.integer :seconds

      t.timestamps
    end
  end
end
