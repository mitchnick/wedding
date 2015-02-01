# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "*** Creating our first user ***"
Admin.create_with(password: "asdfasdf", password_confirmation: "asdfasdf").find_or_create_by(email: "mitchnick@gmail.com")