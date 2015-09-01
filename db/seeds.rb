# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

contracts = [
  {
    timeframe: 1,
    name: "court",
    price: 75
  },
  {
    timeframe: 4,
    name: "long",
    price: 40,
  }
]

gamesessions = [
  {
    virtual_duration: 100,
    real_duration: 10,
    initial_amount_of_cash: 1000,
    initial_number_of_employees: 1,
    salary_per_employee: 100,
    hiring_cost: 200,
    firing_cost: 500,
    productivity_per_employee: 5,
    material_cost: 10,
    name: "Difficulty: Easy"
  }
]

enterprises = [
  {
    name: "Tamayo Inc.",
    game_session_id: 1
  }
]

enterprises.each { |enterprise| Enterprise.create(enterprise) }
contracts.each { |contract| Contract.create(contract) }
gamesessions.each { |gamesession| GameSession.create(gamesession) }
