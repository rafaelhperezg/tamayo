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

contracts.each { |contract| Contract.create(contract) }
