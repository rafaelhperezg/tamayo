class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions


# --------------PRODUCTION METHODS----------

#****DONE****
  def current_number_of_employees
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def today_workshop_production_capacity
    current_number_of_employees * game_session.productivity_per_employee
  end

#****TODO****
  def total_to_produce_today(today_orders_received)
    today_orders_received + backlog_at_the_end_of_previous_day
  end

  def backlog_at_the_end_of_previous_day
    10
  end

  def backlog_at_the_end_of_current_day
    total_to_produce_today - today_workshop_production_capacity
  end

  def products_manufactured_today
    if today_workshop_production_capacity >= total_to_produce_today
      total_to_produce_today
    else
      today_workshop_production_capacity
    end
  end

  def when_can_todays_orders_be_delivered
    total_to_produce_today / today_workshop_production_capacity
  end
# /--------------end PRODUCTION METHODS----------

# -------------COSTS METHODS-------------
  def cost_of_raw_materials_for_today(today_orders_received)
    today_orders_received * game_session.material_cost
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
# /-------------end COSTS METHODS-------------


# --------------SALES METHODS--------------------
  def profit_per_item_in_order_received_today
  end

  def total_sales_for_today
  end
# /--------------end SALES METHODS--------------

# --------------TREASURY METHODS---------------
  def net_result_today
  end

  def total_treasury_today
  end
# /--------------end TREASURY METHODS---------------
end
