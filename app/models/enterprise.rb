class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions


# PRODUCTION METHODS
  def current_number_of_employees
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def today_workshop_production_capacity
  end

  def total_to_produce_today
  end

  def backlog_at_the_end_of_current_day
  end

  def products_manufactured_today
  end

  def when_can_todays_orders_be_delivered
  end

  def compute_salaries_cost
    current_number_of_employees * game_session.salary_per_employee
  end

# COSTS METHODS


# SALES METHODS
  def profit_per_item_in_order_received_today
  end

  def total_sales_for_today
  end

# TREASURY METHODS
  def net_result_today
  end

  def total_treasury_today
  end
end
