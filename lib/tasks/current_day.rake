desc "change day in game"
task change_day: :environment do
  Enterprise.all.each do |ent|
   ent.current_day += 1
   ent.save
  end
  # puts "testing tasks"

end
