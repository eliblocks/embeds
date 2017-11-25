class AddSuspendedToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :suspended, :boolean, default: false
  end
end
