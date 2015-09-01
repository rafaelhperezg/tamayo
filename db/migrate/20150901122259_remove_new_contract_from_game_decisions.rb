class RemoveNewContractFromGameDecisions < ActiveRecord::Migration
  def change
    remove_column :game_decisions, :new_contract_id, :integer
  end
end
