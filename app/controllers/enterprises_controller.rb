
#require './lib/tamayo/tamayocompute.rb'

ORDERS = [20, 20, 20, 20, 20, 10, 20, 10, 20, 30, 30, 10, 30, 20, 10, 30, 10, 10, 10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10]

class EnterprisesController < ApplicationController
  before_action :find_enterprise, :find_game_session, :get_game_decisions
  # todo gamedecisions, current_day

  def show
    @all_enterprises = Enterprise.all
    @previous_game_decision = GameDecision.where(enterprise_id: @enterprise).last
    @current_day = @gamesession.current_day

    # Costs variables
    @today_salary = @enterprise.compute_salaries_cost


    # Production variables
    @current_number_of_employees = @enterprise.current_number_of_employees
    @today_workshop_production_capacity = @enterprise.current_number_of_employees * @gamesession.productivity_per_employee
    @today_orders = ORDERS[@current_day]

    # Treasury variables


    # Sales variables



    # rp code tests
    @today_material_costs= compute_raw_materials_cost

    # pe code
  end

  def compute_raw_materials_cost
    ORDERS[@current_day] * @gamesession.material_cost
  end

  def compute_hiring_firing_cost
    # should be equal to the employes variation of current day * x(if hiring) or y(if firing)
  end

  def total_costs
    return (compute_salaries_cost + compute_raw_materials_cost + compute_hiring_firing_cost)
  end

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

