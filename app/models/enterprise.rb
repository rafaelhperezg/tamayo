ORDERS = [20, 20, 20, 20, 20, 10, 20, 10, 20, 30, 30, 10, 30, 20, 10, 30, 10, 10, 10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10, 30, 20,10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10, 30 , 50, 10, 10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10, 30, 20,10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10]

class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions


# --------------Current day METHOD----------
# This method should be used only when time is managed manually, when each user
# take a decision or the page is reloaded. When we'll use a worker to update current_day
# (in game session!) this method should not be used anymore
  def update_current_day
    self.current_day += 1
    self.save
    return self.current_day
  end


# --------------PRODUCTION METHODS----------

#****DONE (and tested)****
  def current_number_of_employees #Test OK
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def today_workshop_production_capacity #Test OK
    current_number_of_employees * game_session.productivity_per_employee
  end

  def total_to_produce_today(today_orders_received, backlog) #Test OK
    self.est_new_backlog = backlog(today_orders_received, backlog)
    self.save
    today_orders_received + self.current_backlog

  end

  def backlog(today_orders_received, actual_backlog) #Test OK
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
      game_session.firing_cost * employee_variation_from_game_decisions_for_today * -1 #as variation is negatif when firing we need minus one to make positif the expense
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
#****DONE (and tested)****
  def profit_per_item_in_order_received_today(contractual_maximum_number_of_days_to_deliver_order_data, when_can_todays_orders_be_delivered_data, contractual_price_of_item_if_delivered_within_maximum_number_of_days_allowed_data) #Test OK
    if contractual_maximum_number_of_days_to_deliver_order_data >= when_can_todays_orders_be_delivered_data
      contractual_price_of_item_if_delivered_within_maximum_number_of_days_allowed_data
    else
      0
    end
  end

  def total_sales_for_today(products_manufactured_today_data,contract_timeframe, when_orders_delivered, contract_price ) #Test OK
    products_manufactured_today_data * profit_per_item_in_order_received_today(contract_timeframe, when_orders_delivered, contract_price)
  end
# /--------------end SALES METHODS--------------

# --------------TREASURY METHODS---------------
#****DONE (and tested)****
  def total_treasury_today(net_result_today_data) #Test OK

    today_treasury = self.current_cash + net_result_today_data
    self.est_new_cash = today_treasury
  end
# /--------------end TREASURY METHODS---------------

  def find_last_employee_variation(last_decision)
    if last_decision.day_of_decision == ( self.current_day - 1 )
      last_decision.employees_variation
    else
      0
    end
  end


   def hyper_method

    current_day = self.current_day

     # PRODUCTION VARIABLES
     today_orders_received           = ORDERS[current_day -1] #as current_day at start will be updated to 1, the -1 allow as to get ORDERS[0]
     self.current_employees         = self.current_number_of_employees #method
     self.current_prod_capacity     = self.today_workshop_production_capacity #method
     self.current_backlog           = self.est_new_backlog # column
     self.current_to_produce        = self.total_to_produce_today(today_orders_received, self.current_backlog) #method

     self.est_manufactured_today    = self.products_manufactured_today(self.current_prod_capacity, self.current_to_produce) # method
     self.est_delivery_time         = self.when_can_todays_orders_be_delivered(self.current_prod_capacity, self.current_to_produce)

     # COSTS VARIABLES
     self.current_salaries           = self.cost_of_salaries_for_today #Method
     self.current_raw_materials      = self.cost_of_raw_materials_for_today(today_orders_received) #method

     previous_employees_variation    = find_last_employee_variation(game_decisions.last) #method
     self.current_cost_hiring_firing = self.cost_of_hiring_and_firing_for_today(previous_employees_variation)
     total_money_spent_today         = self.current_salaries + self.current_raw_materials + self.current_cost_hiring_firing

     # SALES VARIABLES =>Test for the 3 variables: OK
     self.current_contract_id        = game_decisions.last.new_contract_id #A CALCULER PREV GAME DECISSION
     contract                        = Contract.find(self.current_contract_id)
     self.est_total_sales_today      = self.total_sales_for_today( self.est_manufactured_today, contract.timeframe, self.est_delivery_time, contract.price )

     # TREASURY VARIABLES =>Test for the 2 variables: OK
     self.est_net_result_today       = self.est_total_sales_today - total_money_spent_today
     # @prev_current_cash              = @e.current_cash
     #
     self.current_cash               = self.est_new_cash
     self.est_new_cash               = self.total_treasury_today(self.est_net_result_today) #METHOD

     self.save

  end


end


















