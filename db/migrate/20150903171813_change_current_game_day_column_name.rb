class ChangeCurrentGameDayColumnName < ActiveRecord::Migration
  def change
    rename_column :game_decisions, :current_game_day, :day_of_decision
  end
end
