class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions


# --------------PRODUCTION METHODS----------

#****DONE (and tested)****
  def current_number_of_employees #Test OK
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def today_workshop_production_capacity #Test OK
    current_number_of_employees * game_session.productivity_per_employee
  end

  def total_to_produce_today(today_orders_received, backlog) #Test OK
    prev_backlog = self.current_backlog
    self.current_backlog = backlog(today_orders_received, backlog)
    self.save
    today_orders_received + prev_backlog

  end

  def backlog(today_orders_received, actual_backlog) #Test OK
    # prov_calcul = to_produce_today - today_workshop_production_capacity
    prov_calcul = today_orders_received + actual_backlog - today_workshop_production_capacity
    if prov_calcul > 0
      prov_calcul
    else
      0
    end
  end

  def products_manufactured_today(today_workshop_production_capacity_data, total_to_produce_today_data) #Test OK
    if today_workshop_production_capacity_data >= total_to_produce_today_data
      total_to_produce_today_data
    else
      today_workshop_production_capacity_data
    end
  end
  def when_can_todays_orders_be_delivered(today_workshop_production_capacity_data, total_to_produce_today_data) #Test OK
    total_to_produce_today_data / today_workshop_production_capacity_data
    # sii le produit est pret ce soir le delivery time est zero, on voudra peut etre rajouter un 1
    # pour des raisons des comprehemsion, cest a decider, entout cas la methode marche
  end

# /--------------end PRODUCTION METHODS----------

# -------------COSTS METHODS-------------
#****DONE (and tested)****
  def cost_of_raw_materials_for_today(today_orders_received)  #Test OK
    today_orders_received * game_session.material_cost
    # today_orders_received * cost_of_raw_materials_per_item
  end

  def cost_of_hiring_and_firing_for_today(employee_variation_from_game_decisions_for_today) #Test ok
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

  def cost_of_salaries_for_today   #Test OK
    current_number_of_employees * game_session.salary_per_employee
    # (current_number_of_employees) * (constant_salary_per_employee)
  end

  def total_money_spent_today #Test OK
    cost_of_raw_materials_for_today(ORDERS[gamesession.current_day]) + cost_of_hiring_and_firing_for_today(employee_variation_from_game_decisions_for_today) + cost_of_salaries_for_today
    # (cost_of_raw_materials_for_today) + (cost_of_hiring_and_firing_for_today) + (cost_of_salaries_for_today)
  end
# /-------------end COSTS METHODS-------------


# --------------SALES METHODS--------------------
  def profit_per_item_in_order_received_today
    if contractual_maximum_number_of_days_to_deliver_order <= when_can_todays_orders_be_delivered
      contractual_price_of_item_if_delivered_within_maximum_number_of_days_allowed
    else
      0
    end
  end

  def total_sales_for_today
    products_manufactured_today * profit_per_item_in_order_received_today
  end
# /--------------end SALES METHODS--------------

# --------------TREASURY METHODS---------------
  def net_result_today
    total_sales_for_today - total_money_spent_today
  end

  def total_treasury_today
    treasury_from_yesterday + net_result_today
  end
# /--------------end TREASURY METHODS---------------
end
