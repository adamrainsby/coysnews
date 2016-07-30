class CustomLimiter < Rack::Throttle::Interval
  def allowed?(request)
  #custom logic here
  end
end
