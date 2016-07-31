class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: 'Club'
  belongs_to :away_team, class_name: 'Club'
  has_many :predictions

  validates :home_team, presence: true
  validates :away_team, presence: true

  scope :upcoming, -> { where('kick_off > ?', Time.now - 3.hours).order(:kick_off) }

  def next_match?
    Match.upcoming.first.id == id
  end

  def result? home_goals = home_team_goals, away_goals = away_team_goals
    if home_goals == away_goals
      :draw
    elsif win? home_goals, away_goals
      :win
    else
      :loss
    end
  end

  private

  def win? home_goals, away_goals
    (home? && home_goals > away_goals) || (!home? && away_goals > home_goals)
  end

  def home?
    home_team.name == 'Tottenham Hotspur'
  end
end
