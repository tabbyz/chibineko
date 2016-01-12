# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: "1@1.com", password: "1234")
google = Team.create(name: "google", user_id: user.id)
google.authorized!(user)
Project.create(name: "gmail", user_id: user.id, team_id: google.id)
Project.create(name: "chrome", user_id: user.id, team_id: google.id)

User.create(email: "2@2.com", password: "1234")