#require './lib/tamayo/tamayocompute.rb'

class EnterprisesController < ApplicationController
  def show
    @enterprise = Enterprise.find(params[:id])
    @others = Enterprise.all
    @gamesession = GameSession.find(@enterprise.game_session_id)
    @employees = current_amount_of_employees
    @gamedecisions = GameDecision.where(enterprise_id: @enterprise)
    raise
  end

  def array_of_employee_variations
    @gamedecisions.pluck(:employees_variation)
  end

  # def array_of_contract_changes
  #   @gamedecisions.pluck(:new_contract_id)
  # end

  def initial_number_of_employees
    @gamesession.initial_number_of_employees
  end

  # def initial_amount_of_cash
  #   @gamesession.initial_amount_of_cash
  # end

  # def current_amount_of_employees
  #   array_of_employee_variations << initial_number_of_employees
  # end

  # def current_amount_of_cash
  # end
end


# Calcul du cash disponible

## employee_variation_costs = 0
## if employee_variation > 0
## => employee_variation_costs += hiring_cost
## elsif employee_variation < 0
## => employee_variation_costs -= firing_cost

