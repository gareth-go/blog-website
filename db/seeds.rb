# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.create!(username: 'admin',
               email: 'admin@gmail.com',
               password: '123456',
               role: :admin)

  100.times.each do
    Tag.create!(name: Faker::Lorem.unique.word)
    User.create!(username: Faker::Internet.unique.username(specifier: nil, separators: %w[_]),
                 email: Faker::Internet.unique.email,
                 password: '123456')
  end

  tags = Tag.all
  users = User.all

  100.times.each do
    Post.create!(title: Faker::Lorem.unique.sentence,
                 content: Faker::Lorem.paragraph(sentence_count: 10, supplemental: false, random_sentences_to_add: 5),
                 user: users.sample,
                 tags: tags.sample(4),
                 status: :accepted)
  end

  posts = Post.all

  500.times.each do
    Comment.create!(user: users.sample,
                    post: posts.sample,
                    content: Faker::Lorem.paragraph)
  end

  500.times.each do
    post = posts.sample
    user = users.sample
    comment = post.comments.where(parent_comment: nil).sample

    Comment.create!(user: user,
                    post: post,
                    parent_comment: comment,
                    content: Faker::Lorem.paragraph)

    next if Reaction.exists?(user: user, post: post)

    Reaction.create!(user: user,
                     post: post,
                     reaction_type: rand(5))
  end
end
