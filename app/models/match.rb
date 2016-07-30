class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: 'Club'
  belongs_to :away_team, class_name: 'Club'

  validates :home_team, presence: true
  validates :away_team, presence: true
end
