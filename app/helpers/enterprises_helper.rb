module EnterprisesHelper
  def workshop_productivity
    employees * productivity_per_employee
  end

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

=begin
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
=end
