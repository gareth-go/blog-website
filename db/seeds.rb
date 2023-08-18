# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  100.times.each do |time|
    # Tag.create!(name: Faker::Lorem.unique.word)
    User.create!(username: "#{Faker::Artist.name} #{time}", email: Faker::Internet.unique.email, password: "123456")
  end

  tags = Tag.all
  users = User.all

  100.times.each do
    Post.create!(title: Faker::Lorem.unique.sentence, content: Faker::Lorem.paragraphs, user: users.sample, tags: tags.sample(4))
  end
end
