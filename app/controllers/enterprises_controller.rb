
class EnterprisesController < ApplicationController
  before_action :find_enterprise, :find_game_session, :get_game_decisions
  # todo gamedecisions, current_day

  def show
    @all_enterprises        = Enterprise.all
    @all_enterprises_sorted = @all_enterprises.sort_by { |enterprise| enterprise.current_cash}.reverse
    @gamedecision           = GameDecision.new
    @previous_game_decision = GameDecision.where(enterprise_id: @enterprise).last
    # Next 2 lines will be needed when current_day will be managed by worker
    # @gamesession.current_day = @gamesession.update_current_day
    # @current_day = @gamesession.current_day
    # Next 3 lines will be DELETED when current_day will be managed by worker
    @enterprise.current_day = @enterprise.update_current_day #=>Now this is made by RT
    @current_day = @enterprise.current_day
    @enterprise.hyper_method

# PRODUCTION VARIABLES
    @today_orders_received              = @gamesession.orders[@current_day -1] #as current_day at start will be updated to 1, the -1 allow as to get ORDERS[0]

    @current_number_of_employees        = @enterprise.current_employees
    @today_workshop_production_capacity = @enterprise.current_prod_capacity
    @previous_backlog                   = @enterprise.current_backlog #should be here because in next line backlog will be recalculated when calling total to produce
    @total_to_produce_today             = @enterprise.current_to_produce
    @products_manufactured_today        = @enterprise.est_manufactured_today
    @when_can_todays_orders_be_delivered= @enterprise.est_delivery_time

# COSTS VARIABLES =>Test for the 4 variables: OK
    @cost_of_salaries_for_today          = @enterprise.current_salaries
    @cost_of_raw_materials_for_today     = @enterprise.current_raw_materials
    @cost_of_hiring_and_firing_for_today = @enterprise.current_cost_hiring_firing
    @total_money_spent_today             = @cost_of_salaries_for_today + @cost_of_raw_materials_for_today + @cost_of_hiring_and_firing_for_today

# SALES VARIABLES =>Test for the 3 variables: OK
    @current_contract_id                 = @enterprise.current_contract_id
    @contract                            = Contract.find(@current_contract_id)
    @total_sales_for_today               = @enterprise.est_total_sales_today

# TREASURY VARIABLES =>Test for the 2 variables: OK

    @net_result_today                   = @enterprise.est_net_result_today
    # next  line to update
    @prev_current_cash                  = @enterprise.current_cash   #@enterprise.current_cash
    @current_cash                       = @enterprise.est_new_cash

  end

  # ------Methods for before action---------
  def find_enterprise
    @enterprise     = Enterprise.find(params[:id])
  end

  def find_game_session
    @gamesession    = GameSession.find(@enterprise.game_session_id)
  end

  def get_game_decisions
    @gamedecisions  = GameDecision.where(enterprise_id: @enterprise)
  end
  # /----------------------------------------
end
