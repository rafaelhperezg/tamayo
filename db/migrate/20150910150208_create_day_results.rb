class CreateDayResults < ActiveRecord::Migration
  def change
    create_table :day_results do |t|
      t.integer :cash
      t.integer :day
      t.references :enterprise, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
