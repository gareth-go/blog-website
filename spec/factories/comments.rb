FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content { Faker::Lorem.paragraph }
  end
end
