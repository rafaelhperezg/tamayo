class AddContractIdReference < ActiveRecord::Migration
  def change
    rename_column :game_decisions, :contract_change, :new_contract_id
  end
end
