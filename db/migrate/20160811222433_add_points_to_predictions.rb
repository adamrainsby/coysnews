class AddPointsToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :points, :integer, default: 0
  end
end
