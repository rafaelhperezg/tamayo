class GameDecision < ActiveRecord::Base
  belongs_to :enterprise
  belongs_to :contract
  validates :employees_variation, :numericality => { :only_integer => true }
end
