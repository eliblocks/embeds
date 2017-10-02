class RenameVideoDataToClipData < ActiveRecord::Migration[5.1]
  def change
    rename_column :videos, :video_data, :clip_data
  end
end
