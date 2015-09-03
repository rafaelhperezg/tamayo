class GameDecisionsController < ApplicationController

  def new
    @game_decision = GameDecision.new
    @enterprise = Enterprise.find(params[:enterprise_id])
  end


  def create
    @enterprise = Enterprise.find(params[:enterprise_id])
    @game_decision = GameDecision.new(game_decision_params)
    @game_decision.enterprise = @enterprise
    @game_decision.current_game_day = @enterprise.game_session.current_day
    if @game_decision.save
      redirect_to enterprise_path(@enterprise)
    else
      redirect_to enterprise_path(@enterprise)
      flash.keep[:alert] = "Oops, something went wrong"
    end
  end

  private

  def game_decision_params
    params.require(:game_decision).permit(:employees_variation, :new_contract_id, :current_game_day)
  end
end
