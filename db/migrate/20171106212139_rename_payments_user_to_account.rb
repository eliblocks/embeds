class RenamePaymentsUserToAccount < ActiveRecord::Migration[5.1]
  def change
    rename_column :payments, :user_id, :account_id
  end
end
