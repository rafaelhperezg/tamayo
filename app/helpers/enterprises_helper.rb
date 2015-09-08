module EnterprisesHelper

  # # PRODUCTION VARIABLES
  # today_orders_received              = ORDERS[@current_day -1] #as current_day at start will be updated to 1, the -1 allow as to get ORDERS[0]
  # Enterprise.current_employees       = @enterprise.current_number_of_employees #method
  # Enterprise.current_prod_capacity   = @enterprise.today_workshop_production_capacity #method
  # previous_backlog                   = @enterprise.current_backlog # column
  # Enterprise.current_to_produce      = @enterprise.total_to_produce_today(today_orders_received, @enterprise.current_backlog) #method
  # Enterprise.est_manufactured_today  = @enterprise.products_manufactured_today(today_workshop_production_capacity, total_to_produce_today) # method
  # Enterprise.est_delivery_time       = @enterprise.when_can_todays_orders_be_delivered(@today_workshop_production_capacity, @total_to_produce_today)

  # # COSTS VARIABLES
  # Enterprise.current_salaries           = @enterprise.cost_of_salaries_for_today #Method
  # Enterprise.current_raw_materials      = @enterprise.cost_of_raw_materials_for_today(today_orders_received) #method
  # Enterprise.current_cost_hiring_firing = @enterprise.cost_of_hiring_and_firing_for_today(@gamedecisions.last.employees_variation)#GAME DECISIONS A CALCULER
  # # Enterprise.est_total_costs_today      = current_salaries  + cost_of_raw_materials_for_today + cost_of_hiring_and_firing_for_today

  # # SALES VARIABLES =>Test for the 3 variables: OK
  # # Enterprise.current_contract_id      = @previous_game_decision.new_contract_id #A CALCULER PREV GAME DECISSION
  # # contract                            = Contract.find(@current_contract_id)
  # Enterprise.est_total_sales_today      = @enterprise.total_sales_for_today( @products_manufactured_today, @contract.timeframe, @when_can_todays_orders_be_delivered, @contract.price )

  # # TREASURY VARIABLES =>Test for the 2 variables: OK
  # Enterprise.est_net_result_today       = total_sales_for_today - total_money_spent_today
  # @prev_current_cash                    = @enterprise.current_cash
  # Enterprise.current_cash               = @enterprise.total_treasury_today(@net_result_today) #METHOD

# Enterprise.save

end
