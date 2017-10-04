class AddDefaultToVideosApproved < ActiveRecord::Migration[5.1]
  def change
    change_column_default :videos, :approved, from: nil, to: false
  end
end
