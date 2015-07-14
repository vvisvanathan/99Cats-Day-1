# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(
  name: 'Marshmallow',
  birth_date: "01-01-2014",
  color: 'white',
  sex: 'F',
  description: 'Marshallow is a very sweet and soft kitten'
  )

Cat.create!(
  name: 'Simba',
  birth_date: "12-12-2014",
  color: 'tabby',
  sex: 'M',
  description: 'Simba was the only boy. He just cant wait to be king'
)

Cat.create!(
  name: 'Kyle',
  birth_date: "01-04-2015",
  color: 'black',
  sex: 'F',
  description: 'Kyle is a climber'
)

Cat.create!(
  name: 'Smallcat',
  birth_date: "12-12-2014",
  color: 'grey',
  sex: 'F',
  description: 'Smallcat is the runt. She is very gentle'
)

Cat.create!(
  name: 'Rainbow',
  birth_date: "12-12-2014",
  color: 'tortiseshell',
  sex: 'F',
  description: 'Rainbow is the biggest and always eats everybody else\'s food. She can be a real bully'
)
