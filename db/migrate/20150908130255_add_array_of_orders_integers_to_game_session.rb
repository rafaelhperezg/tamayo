class AddArrayOfOrdersIntegersToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :orders, :integer, array: true, default: []
  end
end
