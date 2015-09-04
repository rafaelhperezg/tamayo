class GameDecisionsController < ApplicationController
  before_action :find_enterprise, :find_game_session
  def new
    @game_decision = GameDecision.new
    @enterprise = Enterprise.find(params[:enterprise_id])
  end


  def create
    @game_decision = @enterprise.game_decisions.build(game_decision_params)
    @game_decision.day_of_decision = @enterprise.game_session.current_day

    if @game_decision.save
      @game_session.current_day += 1
      @game_session.save
      redirect_to enterprise_path(@enterprise)
    else
      redirect_to enterprise_path(@enterprise)
      flash.keep[:alert] = "Oops, something went wrong"
    end
  end

  private

  def game_decision_params
    params.require(:game_decision).permit(:employees_variation, :new_contract_id, :day_of_decision)
  end

# --------Before action methods -------------------
  def find_enterprise
    @enterprise = Enterprise.find(params[:enterprise_id])
  end
  def find_game_session
    @game_session = GameSession.find(@enterprise.game_session_id)
  end
end
