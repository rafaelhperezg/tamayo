class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name
      t.integer :timeframe
      t.integer :price
      t.references :game_session, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
