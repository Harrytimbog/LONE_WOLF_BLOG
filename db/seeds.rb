# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all categories and their dilemmas"
Category.destroy_all if Rails.env.development?

puts "DB restored"
puts "creating categories"

categories = %w[Romance Comedy Lifestyle Education Entertainment Event Travel Health NYSC Politics Movies Agriculture Sexcapade Culture]
categories.each do |category|
  Category.create!(name: category)
end

puts "finished creating categories"
