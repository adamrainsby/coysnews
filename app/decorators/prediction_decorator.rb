class PredictionDecorator < Draper::Decorator
  def summary
    "You predicted a #{h.score(object.home_team_goals, object.away_team_goals)} #{object.result?.to_s}"
  end
end
