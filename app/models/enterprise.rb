class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions

  def current_number_of_employees
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def compute_salaries_cost
    current_number_of_employees * game_session.salary_per_employee
  end
end
