module EnterprisesHelper
  def production_queue
  end

  def print_number_of_employees(number_of_employees)
    if number_of_employees > 1
      "You have #{number_of_employees} employees"
    elsif number_of_employees == 1
      "You have only 1 employee"
    else
      "You don't have any employees"
    end
  end

  def print_hire_fire_costs
  end
end
