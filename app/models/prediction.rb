class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  validates :match, presence: true
  validates :home_team_goals, presence: true
  validates :away_team_goals, presence: true
  validates :match_id, uniqueness: { scope: [:user_id] }

  def result?
    match.result? home_team_goals, away_team_goals
  end
end
