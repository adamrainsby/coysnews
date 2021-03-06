class PredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_match_has_started
  before_action :find_prediction, only: [:edit, :update]

  def new
    @prediction = Prediction.new match_id: params[:match_id]
  end

  def create
    @prediction = Prediction.new prediction_form_fields.merge(user: current_user)

    if @prediction.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    if @prediction.user != current_user
      redirect_to root_path
    end
  end

  def update
    if @prediction.update prediction_form_fields
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def check_if_match_has_started
    if Match.find(params[:match_id]).has_started?
      flash[:danger] = 'This match has started.'
      redirect_to root_path
    end
  end

  def find_prediction
    @prediction = Prediction.find params[:id]
  end

  def prediction_form_fields
    params.require(:prediction).permit(
      :home_team_goals,
      :away_team_goals
    ).merge(user: current_user, match_id: params[:match_id])
  end
end
