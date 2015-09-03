#require './lib/tamayo/tamayocompute.rb'

class EnterprisesController < ApplicationController
  def show
    @enterprise = Enterprise.find(params[:id])
    @others = Enterprise.all
    @gamesession = GameSession.find(@enterprise.game_session_id)
    @employees = current_amount_of_employees
    @game_decision = GameDecision.new
  end

  def current_amount_of_employees
    gamesession_params = GameSession.find(1)
    initial_amount_of_employees = gamesession_params.initial_number_of_employees
    employee_variation = GameDecision.pluck(:employees_variation)
    employee_variation << initial_amount_of_employees
    return employee_variation.reduce(:+)
  end
end
