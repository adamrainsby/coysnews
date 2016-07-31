class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.references :match, index: true
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.references :user, index: true

      t.timestamps
    end
  end
end
