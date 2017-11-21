class ChangeForeignKeysToAccount < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :charges, :users
    remove_foreign_key :payments, :users
    remove_foreign_key :plays, :users

    add_foreign_key :charges, :accounts
    add_foreign_key :payments, :accounts
    add_foreign_key :plays, :accounts
  end
end
