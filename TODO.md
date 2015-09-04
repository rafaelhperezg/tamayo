- Cannot have a negative amount of employees

Dans l'interface: présentation de l'entreprise la veille
Afficher la commande du jour

- Compute the best possible score (had the player known upcoming orders)
--> hardcore algorithm!


Worker:

When a player saves decisions for current day, day_of_decision is incremented to +1
When the worker is triggered it checks if day_of_decision matches the session's current_day
if it does, it saves the day's decision with employee_variation = 0 and the same contract
THEN increments to next day


PRODUCTIVITY
  number_of_employees
    ( initial_number_of_employees + employees_variation.reduce(:+) )
  workshop_capacity
    (number_of_employees) * (productivity_per_employee)
  total_to_produce
    (backlog) + (today_orders)
  production_queue
    (total_to_produce) - (workshop_capacity)
  products_manufactured
    if (workshop_capacity) >= (total_to_produce)
      (total_to_produce)
    else
      (workshop_capacity)
  delivery_time
    (total_to_produce) / (workshop_capacity)

COSTS
  compute_raw_materials_cost
    (orders) * (material_cost)
  compute_hiring_firing_cost
    if (employee_variation) > 0
      (hiring_cost) * (employee_variation)
    elsif (employee_variation) < 0
      (firing_cost) * (employee_variation)
    else
      0
  compute_salaries_cost
    (current_number_of_employees) * (salary_per_employee)
  total_costs
    (compute_raw_materials_cost) + (compute_hiring_firing_cost) + (compute_salaries_cost)

SALES
  profit_per_item
    if (timeframe) =< (delivery_time)
      (price)
    else
      0
  total_sales
    (products_manufactured) * (profit_per_item)

  TREASURY
    net_results
      (total_sales) - (total_costs)
    treasury
      (treasury) - (net_results)
