# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Destroying all categories"
Category.destroy_all if Rails.env.development?

puts "DB restored"

puts "Creating Fake users"

5.times do
  user = User.new(
    email: Faker::Internet.email,
    nickname: Faker::Military.army_rank,
    password: "123456"
  )
  user.save!
end

puts "Finished creating fake users"

puts "creating categories"

categories = %w[Investment Trading Moneytips]
categories.each do |category|
  Category.create!(name: category)
end

puts "finished creating categories"
