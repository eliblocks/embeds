class RenamePlaysUserIdToAccountId < ActiveRecord::Migration[5.1]
  def change
    rename_column :plays, :user_id, :account_id
  end
end
