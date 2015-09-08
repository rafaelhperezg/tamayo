# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


GameSession.destroy_all
Contract.destroy_all
Enterprise.destroy_all
GameDecision.destroy_all

sample_orders = [10,20,30]
array_of_orders = []

200.times do
  array_of_orders << sample_orders.sample
end

gamesessions = [
  {
    virtual_duration: 100,
    real_duration: 10,
    initial_amount_of_cash: 10000,
    initial_number_of_employees: 1,
    salary_per_employee: 100,
    hiring_cost: 200,
    firing_cost: 500,
    productivity_per_employee: 5,
    material_cost: 10,
    name: "Difficulty: Easy",
    current_day: 0,
    initial_backlog: 0,
    orders: array_of_orders,
  }
]

contracts = [
  {
    timeframe: 1,
    name: "court",
    price: 75,
    game_session_id: 1
  },
  {
    timeframe: 4,
    name: "long",
    price: 40,
    game_session_id: 1
  }
]

enterprises = [
  {
    name: "Tamayo Inc.",
    game_session_id: 1,
    current_backlog: 0,
    current_cash: 10000,
    current_day: 0
  },
  {
    name: "Rafa Inc.",
    game_session_id: 1,
    current_backlog: 0,
    current_cash: 10000,
    current_day: 0
  },
  {
    name: "PE Inc.",
    game_session_id: 1,
    current_backlog: 0,
    current_cash: 10000,
    current_day:0
  }

]

gamesessions.each { |gamesession| GameSession.create(gamesession) }
contracts.each { |contract| Contract.create(contract) }
enterprises.each { |enterprise| Enterprise.create(enterprise) }

dec = GameDecision.new(day_of_decision:0, employees_variation:0,enterprise_id:1,new_contract_id:2)
dec.save
dec = GameDecision.new(day_of_decision:0, employees_variation:0,enterprise_id:2,new_contract_id:2)
dec.save
dec = GameDecision.new(day_of_decision:0, employees_variation:0,enterprise_id:3,new_contract_id:2)
dec.save
