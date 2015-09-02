class GameDecisionsController < ApplicationController

  def new
    @previous_day = GameDecision.last.current_game_day
    @game_decision = GameDecision.new
    @enterprise = Enterprise.find(params[:enterprise_id])
  end


  def create
    @enterprise = Enterprise.find(params[:enterprise_id])
    @game_decision = GameDecision.new(game_decision_params)
    @game_decision.enterprise = @enterprise
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
