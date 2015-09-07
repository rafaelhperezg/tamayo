class AddInitialBacklogToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :initial_backlog, :integer
  end
end
