class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions

  def current_number_of_employees
    game_session.initial_number_of_employees + game_decisions.sum(:employees_variation)
  end

  def compute_salaries_cost
    current_number_of_employees * game_session.salary_per_employee
  end

  # ------------RP: Costs calcul----------------------

    def cost_of_raw_materials_for_today(current_day)
      ORDERS[current_day] * gamesession.material_cost
      # today_orders_received * cost_of_raw_materials_per_item
    end
end
