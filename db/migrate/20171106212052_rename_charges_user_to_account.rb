class RenameChargesUserToAccount < ActiveRecord::Migration[5.1]
  def change
    rename_column :charges, :user_id, :account_id
  end
end
