class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: 'Club'
  belongs_to :away_team, class_name: 'Club'
  has_many :predictions

  validates :home_team, presence: true
  validates :away_team, presence: true

  scope :upcoming, -> { where('kick_off > ?', Time.now - 3.hours).order(:kick_off) }

  include ArrayStats

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

  def update_score home_goals, away_goals
    self.update home_team_goals: home_goals, away_team_goals: away_goals

    predictions.each do |prediction|
      prediction.update_points!
    end
  end

  def has_started?
    kick_off < Time.now
  end

  def average_prediction
    [
      median(predictions.pluck(:home_team_goals)).round,
      median(predictions.pluck(:away_team_goals)).round
    ]
  end

  private

  def win? home_goals, away_goals
    (home? && home_goals > away_goals) || (!home? && away_goals > home_goals)
  end

  def home?
    home_team.name == 'Tottenham Hotspur'
  end
end
