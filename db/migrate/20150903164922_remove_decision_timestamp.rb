class RemoveDecisionTimestamp < ActiveRecord::Migration
  def change
    remove_column :game_decisions, :decision_timestamp
  end
end
