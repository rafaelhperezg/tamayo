#require './lib/tamayo/tamayocompute.rb'

class EnterprisesController < ApplicationController
  def show
    @enterprise = Enterprise.find(params[:id])
    @others = Enterprise.all
    @gamesession = GameSession.find(@enterprise.game_session_id)
    @preview_game_day = GameDecision.where(enterprise_id: @enterprise).last
    @gamedecision = GameDecision.where(enterprise_id: @enterprise).last
    @gamedecisions = GameDecision.where(enterprise_id: @enterprise)
    @employees = @gamedecisions.pluck(:employees_variation).reduce(:+)
  end

  # def array_of_employee_variations
  #   @gamedecisions.pluck(:employees_variation)
  # end

  # def array_of_contract_changes
  #   @gamedecisions.pluck(:new_contract_id)
  # end

  # def initial_number_of_employees
  #   @gamesession.initial_number_of_employees
  # end

  # def initial_amount_of_cash
  #   @gamesession.initial_amount_of_cash
  # end

  # def current_amount_of_employees
  #   array_of_employee_variations << initial_number_of_employees
  # end

  # def current_amount_of_cash
  # end
end

# -  def current_amount_of_employees    +  def array_of_employee_variations
# -    gamesession_params = GameSession.find(3)   +    @gamedecisions.pluck(:employees_variation)
# -    initial_amount_of_employees = gamesession_params.initial_number_of_employees
# -    employee_variation = GameDecision.pluck(:employees_variation)
# -    return employee_variation.reduce(:+) + initial_amount_of_employees
#    end


# Calcul du cash disponible

## employee_variation_costs = 0
## if employee_variation > 0
## => employee_variation_costs += hiring_cost
## elsif employee_variation < 0
## => employee_variation_costs -= firing_cost

