class AddCurrentDayToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :current_day, :integer
  end
end
