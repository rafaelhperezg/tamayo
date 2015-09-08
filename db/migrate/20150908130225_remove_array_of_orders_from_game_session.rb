class RemoveArrayOfOrdersFromGameSession < ActiveRecord::Migration
  def change
    remove_column :game_sessions, :orders
  end
end
