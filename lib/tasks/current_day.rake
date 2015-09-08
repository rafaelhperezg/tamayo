desc "change day in game"
task change_day: :environment do

  GameSession.first.update_current_day

  Enterprise.all.each do |ent|
    ent.update_current_day
    ent.hyper_method
  end

end
