desc "change day in game"
task change_day: :environment do

  if GameSession.first.current_day <= GameSession.first.virtual_duration
    GameSession.first.update_current_day

    Enterprise.all.each do |ent|
      ent.update_current_day
      # ent.hyper_method
      RunGameJob.perform_later ent.id
    end
  else
    puts "The game is finished"
  end

end
