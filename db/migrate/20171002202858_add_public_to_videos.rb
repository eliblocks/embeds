class AddPublicToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :public, :boolean, default: false
  end
end
