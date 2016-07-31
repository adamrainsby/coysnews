class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.datetime :kick_off
      t.integer :home_team_goals
      t.integer :away_team_goals

      t.timestamps
    end

    tottenham = Club.find_by name: 'Tottenham Hotspur'
    everton = Club.find_by name: 'Everton'
    crystal_palace = Club.find_by name: 'Crystal Palace'
    liverpool = Club.find_by name: 'Liverpool'
    stoke = Club.find_by name: 'Stoke City'
    sunderland = Club.find_by name: 'Sunderland'

    Match.create home_team: everton, away_team: tottenham, kick_off: Time.zone.parse('13/08/2016 13:00')
    Match.create home_team: tottenham, away_team: crystal_palace, kick_off: Time.zone.parse('20/08/2016 15:00')
    Match.create home_team: tottenham, away_team: liverpool, kick_off: Time.zone.parse('27/08/2016 12:30')
    Match.create home_team: stoke, away_team: tottenham, kick_off: Time.zone.parse('10/09/2016 15:00')
    Match.create home_team: tottenham, away_team: sunderland, kick_off: Time.zone.parse('18/09/2016 16:30')
  end
end
