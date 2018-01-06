class AddLanguageToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :language, :string
  end
end
