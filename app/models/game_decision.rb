class GameDecision < ActiveRecord::Base
  belongs_to :enterprise
  belongs_to :contract
end
