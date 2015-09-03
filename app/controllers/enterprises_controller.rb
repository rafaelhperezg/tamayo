#require './lib/tamayo/tamayocompute.rb'
class EnterprisesController < ApplicationController

  before_action :find_enterprise, :find_game_session, :get_game_desicions
  # todo gamedecisions, current_day
  def show
    @others = Enterprise.all
    @gamedecisions = GameDecision.where(enterprise_id: @enterprise)
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


# ------------RP: Costs calcul----------------------
  def current_number_of_employees
    @initial_number_of_employees = @gamesession.initial_number_of_employees
    return (@initial_number_of_employees - @gamedecisions.map {|gd| gd.employees_variation}.reduce(:+))
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

  def get_game_desicions
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

