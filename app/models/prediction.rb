class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  validates :match, presence: true
  validates :home_team_goals, presence: true
  validates :away_team_goals, presence: true
  validates :home_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validates :away_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validates :match_id, uniqueness: { scope: [:user_id] }

  def result?
    match.result? home_team_goals, away_team_goals
  end

  def update_points!
    if correct_score?
      self.update points: 3
    elsif correct_result?
      self.update points: 1
    else
      self.update points: 0
    end
  end

  private

  def correct_score?
    if home_team_goals == match.home_team_goals && away_team_goals == match.away_team_goals
      true
    else
      false
    end
  end

  def correct_result?
    if result? == match.result?
      true
    else
      false
    end
  end
end
