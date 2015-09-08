class RunGameJob < ActiveJob::Base
  queue_as :default

  def perform
    # Do something later
    puts "starting fakejob"
    sleep 15
    puts "end fakejob"
  end
end
