class RenameTypeToCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :type, :category
  end
end
