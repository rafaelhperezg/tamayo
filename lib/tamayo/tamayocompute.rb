  def current_amount_of_employees
    count = 0
    gamesession_params = GameSession.find(3)
    initial_amount_of_employees = gamesession_params.initial_number_of_employees
    return employee_variation = GameDecision.pluck(:employees_variation)
  end

p current_amount_of_employees
