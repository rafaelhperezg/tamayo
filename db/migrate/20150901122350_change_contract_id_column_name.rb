class ChangeContractIdColumnName < ActiveRecord::Migration
  def change
    rename_column :game_decisions, :contract_id, :new_contract_id
  end
end
