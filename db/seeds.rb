# frozen_string_literal: true

require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  name  = Faker::Name.first_name
  email = Faker::Internet.email
  user_id = (1..10).to_a
  quote = Faker::Quote.famous_last_words
  post_title = Faker::Book.title
  password = 'foobar'
  a = User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
  a.posts.new(title: post_title, body: quote, user_id: user_id.sample(1))
  a.save
end
