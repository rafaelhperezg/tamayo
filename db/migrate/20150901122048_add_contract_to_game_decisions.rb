class AddContractToGameDecisions < ActiveRecord::Migration
  def change
    add_reference :game_decisions, :contract, index: true, foreign_key: true
  end
end
