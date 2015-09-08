-display an error message if firing too much people




--> Keep previous contract as default for subsequent decisions

Worker:

When a player saves decisions for current day, day_of_decision is incremented to +1
When the worker is triggered it checks if day_of_decision matches the session's current_day
if it does, it saves the day's decision with employee_variation = 0 and the same contract
THEN increments to next day


- Compute the best possible score (had the player known upcoming orders)
--> hardcore algorithm!

#PRODUCTIVITY

    - current_number_of_employees
        ( initial_number_of_employees + employees_variation_from_game_decisions.reduce(:+) )

    - today_workshop_production_capacity
        (current_number_of_employees) * (productivity_per_employee)

    - total_to_produce_today
        (backlog_from_previous_day) + (today_orders_received)

    - backlog_at_the_end_of_current_day
        (total_to_produce_today) - (today_workshop_production_capacity)

    - products_manufactured_today
        if (today_workshop_production_capacity) >= (total_to_produce_today)
          (total_to_produce_today)
        else
          (today_workshop_production_capacity)

    - when_can_todays_orders_be_delivered
        (total_to_produce_today) / (today_workshop_production_capacity)

#COSTS

    - cost_of_raw_materials_for_today
        (today_orders_received) * (cost_of_raw_materials_per_item)

    - cost_of_hiring_and_firing_for_today
        if (employee_variation_from_game_decisions_for_today) > 0
            (constant_employee_hiring_cost) * (employee_variation_from_game_decisions_for_today)
        elsif (employee_variation_from_game_decisions_for_today) < 0
            (constant_employee_firing_cost) * (employee_variation_from_game_decisions_for_today)
        else
            0

    - cost_of_salaries_for_today
        (current_number_of_employees) * (constant_salary_per_employee)

    - total_money_spent_today
        (cost_of_raw_materials_for_today) + (cost_of_hiring_and_firing_for_today) + (cost_of_salaries_for_today)

#SALES

    - profit_per_item_in_order_received_today
        if (contractual_maximum_number_of_days_to_deliver_order) <= (when_can_todays_orders_be_delivered)
            (contractual_price_of_item_if_delivered_within_maximum_number_of_days_allowed)
        else
            0

    - total_sales_for_today
        (products_manufactured_today) * (profit_per_item_in_order_received_today)

#TREASURY

    - net_result_today
        (total_sales_for_today) - (total_money_spent_today)

    - total_treasury_today
        (treasury_from_yesterday) + (net_result_today)








  question rp (la plus longue de lhistoire des tickets des ta)
  On est parti sur la creation d'une rake task. Pas de job pour l'instant car si
on a bien compris ils s'utilisent surtout pour donner de la vitesse a la page
et actuellement on n'en a pas peut etre besoin?
Sur la rake test, quand on lappelle manuellement, on arrive a incrementer le
current day de l'entreprise, car current day est une variable du model Enterprise
et du coup on peut la modifier manuellenemnt (on un appelant la methode unpdate_current_day
qu'appartient au modele Enterprise).
Pour les autres variables du jeu qui devraient sincrementer quand on appelle la
rake task, on a un probleme. la pluspart de ves variables ne sont pas de variables
du modele Enterprise, ils s'agit juste des variables d'instances du method show du model Enterprise. Ces variables se recalculent quand on fait un show sur la page (en prenant
une decision ou en faisant un reload sur la page).
Comment on recalcule ces variables d'instances avec notre rake test, comment simmuler
un show?
Pou l'instant la piste est plutot d'ajouter toutes ces variables au model Enterprise
car de cettemaniere, dans le rake test on pourra appeller les methodes du modele En-
terprise qui viendront mettre  à jour les variables du modele (car on ne vois pas comment ces methodes peuvent aller modifier des variables d'instances (@xxxx) en show)
Du coup, par la suite en show, pour connaitre les valeur des variable, on fera,
par exemple:
@total_to_produce_today = @enterprise.total_to_produce_today
