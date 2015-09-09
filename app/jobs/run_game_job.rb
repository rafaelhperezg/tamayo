class RunGameJob < ActiveJob::Base
  queue_as :default

  def perform(enterprise_id)
    # Do something later
    # puts "starting fakejob"
    # sleep 15
    # puts "end fakejob"
    enterprise = Enterprise.find(enterprise_id)
    enterprise.hyper_method
  end
end
