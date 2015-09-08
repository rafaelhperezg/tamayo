class PagesController < ApplicationController
  def home
    @enterprise = Enterprise.find(1)
    @employees_variation_history = @enterprise.pluck(:employees_variation)
    @contract_decisions_history = @enterprise.pluck(:new_contract_id)
    raise
  end

  def evolution_of_orders
    @evolution = enterprise
  end

  def json_decisions
    render json: GameDecision.where(enterprise_id: 2)
  end
end
