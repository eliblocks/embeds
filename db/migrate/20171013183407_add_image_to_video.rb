class AddImageToVideo < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :image, :string
  end
end
