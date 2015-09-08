class AddArrayOfOrdersToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :orders, :text, array: true, default: []
  end
end
