class ChangeColumnNames < ActiveRecord::Migration
  def change
    rename_column :game_sessions, :start_cash, :initial_cash
    rename_column :game_sessions, :start_amount_of_employees, :initial_number_of_employees
  end
end
