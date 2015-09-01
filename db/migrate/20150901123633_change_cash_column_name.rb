class ChangeCashColumnName < ActiveRecord::Migration
  def change
    rename_column :game_sessions, :initial_cash, :initial_amount_of_cash
  end
end
