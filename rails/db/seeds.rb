# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# AGOT
# character  city  dragon  house  quote

if People.count == 0
  50.times do
    Person.create(name: Faker::GameOfThrones.character)
  end
end
