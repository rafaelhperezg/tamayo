class CreateEnterprises < ActiveRecord::Migration
  def change
    create_table :enterprises do |t|
      t.string :name
      t.references :game_session, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
