class PagesController < ApplicationController
  def home
    @enterprise = Enterprise.find(1).game_decisions
    @suite = [200, 300, 400, 800, 900, 1500, 2500, 4000]
  end

  def json_decisions
    render json: GameDecision.where(enterprise_id: 2)
  end
end
