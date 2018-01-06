class AddImdbIdToVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :imdb_id, :string
  end
end
