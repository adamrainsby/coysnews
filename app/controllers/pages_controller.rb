class PagesController < ApplicationController
  def home
    @matches = Match.upcoming.first(5)
  end

  def table
    @users = User.users_ordered_by_points.each_with_index
  end
end
