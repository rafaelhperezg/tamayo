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
