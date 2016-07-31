module ApplicationHelper
  def score home_goals, away_goals
    if home_goals == away_goals
      "#{home_goals}-#{away_goals}"
    else
      goals = [home_goals, away_goals]
      "#{goals.max}-#{goals.min}"
    end
  end
end
