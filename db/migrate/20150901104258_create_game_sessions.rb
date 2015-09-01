class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.integer :virtual_duration
      t.integer :real_duration
      t.integer :start_cash
      t.integer :start_amount_of_employees
      t.integer :salary_per_employee
      t.integer :hiring_cost
      t.integer :firing_cost
      t.integer :productivity_per_employee
      t.integer :material_cost

      t.timestamps null: false
    end
  end
end
