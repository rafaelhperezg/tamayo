#require './lib/tamayo/tamayocompute.rb'

ORDERS = [20, 20, 20, 20, 20, 10, 20, 10, 20, 30, 30, 10, 30, 20, 10, 30, 10, 10, 10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10]

class EnterprisesController < ApplicationController

  before_action :find_enterprise, :find_game_session, :get_game_decisions
  # todo gamedecisions, current_day
  def show
    @others = Enterprise.all
    @previous_game_decision = GameDecision.where(enterprise_id: @enterprise).last
    @current_game_day = @previous_game_decision.current_game_day + 1
    @gamedecision = GameDecision.where(enterprise_id: @enterprise).last
    @employees = current_number_of_employees
    @workshop_capacity = @employees * @gamesession.productivity_per_employee
    @today_orders = ORDERS[@current_game_day]
  end

# ------------RP: Costs calcul----------------------
  def current_number_of_employees
    @initial_number_of_employees = @gamesession.initial_number_of_employees
    return (@initial_number_of_employees + @gamedecisions.map {|gd| gd.employees_variation}.reduce(:+))
  end

# ------------RP: Costs calcul----------------------

  def compute_salaries_cost
    current_number_of_employees * @gamesession.salary_per_employee
  end

  def compute_raw_materials_cost
    orders[current_day] * @gamesession.material_cost
  end

  def compute_hiring_firing_cost
    # should be equal to the employes variation of current day * x(if hiring) or y(if firing)
  end

  def total_costs
    return (compute_salaries_cost + compute_raw_materials_cost + compute_hiring_firing_cost)
  end
  # /end costs calcul ----------------------

  # ------Methodes for before action---------
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

