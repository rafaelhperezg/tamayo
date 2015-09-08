desc "change day in game"
task change_day: :environment do
  # Enterprise.show

  Enterprise.all.each do |ent|
    # rr = EnterprisesController.new
    # rr.say_hi
    ent.update_current_day
    ent.hyper_method

   # ent.current_day += 1
   # ent.save
   # ent.update_current_day
  end

  # puts "testing tasks"

end
