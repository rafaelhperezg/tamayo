@currentday = GameDecision.last.current_game_day

module EnterprisesHelper
  def workshop_productivity
    employees * productivity_per_employee
  end

  def production_queue

  end
end
