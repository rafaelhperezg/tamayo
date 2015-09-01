class Enterprise < ActiveRecord::Base
  belongs_to :game_session
  has_many :game_decisions
end
