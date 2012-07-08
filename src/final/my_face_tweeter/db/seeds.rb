# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

User.create!(:email => "alice@wonderland.com", :password => "the_white_rabbit", :password_confirmation => "the_white_rabbit", :name => "Alice", :dob => "01/01/1930")

User.create!(:email => "bob_the_builder@southern_electric_constrution.com", :password => "bricks_n_mortar", :password_confirmation => "bricks_n_mortar", :name => "Bob", :dob => "01/01/1950")

User.create!(:email => "charlie_brown@peanuts.com", :password => "what_a_nightmare", :password_confirmation => "what_a_nightmare", :name => "Charlie", :dob => "01/01/1960")

