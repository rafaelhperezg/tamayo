class AddNameToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :name, :string
  end
end
