class GameSession < ActiveRecord::Base
  has_many :contracts
  has_many :enterprises

  def update_current_day
    # This method will serve us when the current_day will be updated with a worker
    # self.current_day += 1
    # self.save
    # return self.current_day
  end
end
