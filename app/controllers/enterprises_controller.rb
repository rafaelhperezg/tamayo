
#require './lib/tamayo/tamayocompute.rb'

ORDERS = [20, 20, 20, 20, 20, 10, 20, 10, 20, 30, 30, 10, 30, 20, 10, 30, 10, 10, 10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10]

class EnterprisesController < ApplicationController
  before_action :find_enterprise, :find_game_session, :get_game_decisions
  # todo gamedecisions, current_day

  def show
    @all_enterprises = Enterprise.all
    @previous_game_decision = GameDecision.where(enterprise_id: @enterprise).last
    @current_day = @gamesession.current_day

# COSTS VARIABLES
    @today_salary = @enterprise.compute_salaries_cost


# PRODUCTION VARIABLES
    @current_number_of_employees = @enterprise.current_number_of_employees
    @today_workshop_production_capacity = @enterprise.current_number_of_employees * @gamesession.productivity_per_employee
    @today_orders = ORDERS[@current_day]

# TREASURY VARIABLES


# SALES VARIABLES

    # rp code tests
    @today_material_costs= compute_raw_materials_cost

  end

  # ------Methods for before action---------
  def find_enterprise
    @enterprise = Enterprise.find(params[:id])
  end

  def find_game_session
    @gamesession = GameSession.find(@enterprise.game_session_id)
  end

  def get_game_decisions
    @gamedecisions = GameDecision.where(enterprise_id: @enterprise)
  end
  # /----------------------------------------

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

