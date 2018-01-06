class AddRatingToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :rating, :string
  end
end
