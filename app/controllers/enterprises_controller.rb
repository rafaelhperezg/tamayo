#require './lib/tamayo/tamayocompute.rb'

class EnterprisesController < ApplicationController
  def show
    @enterprise = Enterprise.find(params[:id])
    @others = Enterprise.all
    @gamesession = GameSession.find(@enterprise.game_session_id)
    @employees = current_amount_of_employees
  end

  def current_amount_of_employees
    gamesession_params = GameSession.find(3)
    initial_amount_of_employees = gamesession_params.initial_number_of_employees
    employee_variation = GameDecision.pluck(:employees_variation)
    return employee_variation.reduce(:+) + initial_amount_of_employees
  end
end
