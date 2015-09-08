module EnterprisesHelper

  # PRODUCTION VARIABLES
  today_orders_received              = ORDERS[@current_day -1] #as current_day at start will be updated to 1, the -1 allow as to get ORDERS[0]
  current_number_of_employees        = @enterprise.current_number_of_employees #method
  today_workshop_production_capacity = @enterprise.today_workshop_production_capacity #method
  previous_backlog                   = @enterprise.current_backlog # column
  total_to_produce_today             = @enterprise.total_to_produce_today(today_orders_received, @enterprise.current_backlog) #method
  products_manufactured_today        = @enterprise.products_manufactured_today(today_workshop_production_capacity, total_to_produce_today) # method
  when_can_todays_orders_be_delivered= @enterprise.when_can_todays_orders_be_delivered(@today_workshop_production_capacity, @total_to_produce_today)

  # COSTS VARIABLES
  cost_of_salaries_for_today          = @enterprise.cost_of_salaries_for_today #Method
  cost_of_raw_materials_for_today     = @enterprise.cost_of_raw_materials_for_today(today_orders_received) #method
  cost_of_hiring_and_firing_for_today = @enterprise.cost_of_hiring_and_firing_for_today(@gamedecisions.last.employees_variation)#GAME DECISIONS A CALCULER
  total_money_spent_today             = cost_of_salaries_for_today + cost_of_raw_materials_for_today + cost_of_hiring_and_firing_for_today

  # SALES VARIABLES =>Test for the 3 variables: OK
  current_contract_id                 = @previous_game_decision.new_contract_id #A CALCULER PREV GAME DECISSION
  contract                            = Contract.find(@current_contract_id)
  total_sales_for_today               = @enterprise.total_sales_for_today( @products_manufactured_today, @contract.timeframe, @when_can_todays_orders_be_delivered, @contract.price )

  # TREASURY VARIABLES =>Test for the 2 variables: OK
  net_result_today                   = total_sales_for_today - total_money_spent_today
  @prev_current_cash                  = @enterprise.current_cash
  @current_cash                       = @enterprise.total_treasury_today(@net_result_today) #METHOD


end
