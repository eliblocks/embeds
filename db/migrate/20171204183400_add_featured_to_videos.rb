class AddFeaturedToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :featured, :boolean, default: false
  end
end
