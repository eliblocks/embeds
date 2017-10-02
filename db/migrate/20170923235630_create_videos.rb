class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.integer :duration
      t.integer :price, default: 1
      t.boolean :approved
      t.text :video_data
      t.integer :balance, default: 0
      t.integer :views, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
