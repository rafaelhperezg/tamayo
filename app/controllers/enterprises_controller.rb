class EnterprisesController < ApplicationController
  def show
    @enterprise = Enterprise.find(params[:id])
    @others = Enterprise.all
    @gamesession = GameSession.find(3)
  end
end
