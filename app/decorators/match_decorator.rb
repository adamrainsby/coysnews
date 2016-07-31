class MatchDecorator < Draper::Decorator
  def kick_off_date_and_time
    object.kick_off.strftime("%d/%m/%Y %H:%M")
  end
end
