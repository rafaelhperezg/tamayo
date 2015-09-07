class PagesController < ApplicationController
  def home
    @enterprise = Enterprise.find(1)
  end

  def json_decisions
    render json: GameDecision.where(enterprise_id: 2)
  end
end
