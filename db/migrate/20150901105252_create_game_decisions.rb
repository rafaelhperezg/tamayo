class CreateGameDecisions < ActiveRecord::Migration
  def change
    create_table :game_decisions do |t|
      t.datetime :decision_timestamp
      t.integer :current_game_day
      t.integer :employees_variation
      t.integer :contract_change
      t.references :enterprise, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
