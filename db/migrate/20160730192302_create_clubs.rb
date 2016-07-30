class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name

      t.timestamps
    end

    [
      'Tottenham Hotspur',
      'Arsenal',
      'Bournemouth',
      'Burnley',
      'Chelsea',
      'Crystal Palace',
      'Everton',
      'Hull City',
      'Leicester City',
      'Liverpool',
      'Manchester City',
      'Manchester United',
      'Middlesbrough',
      'Southampton',
      'Stoke City',
      'Sunderland',
      'Swansea City',
      'Watford',
      'West Bromwich Albion',
      'West Ham United'
    ].each do |name|
      Club.create name: name
    end
  end
end













