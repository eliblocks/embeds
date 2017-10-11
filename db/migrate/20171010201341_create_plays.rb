class CreatePlays < ActiveRecord::Migration[5.1]
  def change
    create_table :plays do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true
      t.integer :duration
      t.integer :price, default: 1

      t.timestamps
    end
  end
end
