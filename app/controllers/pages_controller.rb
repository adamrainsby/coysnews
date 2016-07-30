class PagesController < ApplicationController
  def home
    @matches = Match.all
  end
end
