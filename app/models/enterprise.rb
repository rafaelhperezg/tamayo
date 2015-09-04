class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions

  def current_number_of_employees
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def compute_salaries_cost
    current_number_of_employees * game_session.salary_per_employee
  end

  # ------------Costs calcul----------------------

  def cost_of_raw_materials_for_today(current_day)
    ORDERS[current_day] * gamesession.material_cost
    # today_orders_received * cost_of_raw_materials_per_item
  end

  def cost_of_hiring_and_firing_for_today(employee_variation_from_game_decisions_for_today)
    if (employee_variation_from_game_decisions_for_today) > 0
      game_session.hiring_cost * employee_variation_from_game_decisions_for_today
    # (constant_employee_hiring_cost) * (employee_variation_from_game_decisions_for_today)
    elsif (employee_variation_from_game_decisions_for_today) < 0
      game_session.firing_cost * employee_variation_from_game_decisions_for_today
    # (constant_employee_firing_cost) * (employee_variation_from_game_decisions_for_today)
    else
      0
    end
  end

  def cost_of_salaries_for_today
    current_number_of_employees * game_session.salary_per_employee
    # (current_number_of_employees) * (constant_salary_per_employee)
  end

  def total_money_spent_today
    cost_of_raw_materials_for_today(current_day) + cost_of_hiring_and_firing_for_today(employee_variation_from_game_decisions_for_today) + cost_of_salaries_for_today
    # (cost_of_raw_materials_for_today) + (cost_of_hiring_and_firing_for_today) + (cost_of_salaries_for_today)
  end
  # /end costs calcul ----------------------
end
