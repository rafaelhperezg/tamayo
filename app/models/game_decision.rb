class GameDecision < ActiveRecord::Base
  belongs_to :enterprise
  belongs_to :contract
  validates :employees_variation, :numericality => { :only_integer => true }

  validate :minimum_employee_count

  def minimum_employee_count
    if enterprise.current_number_of_employees + employees_variation < 0
      errors.add :employees_variation, "Employee count cannot be negative"
    end
  end
end
