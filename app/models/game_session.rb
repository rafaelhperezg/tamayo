class GameSession < ActiveRecord::Base
  has_many :contracts
  has_many :enterprises
end
