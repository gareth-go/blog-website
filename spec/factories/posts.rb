FactoryBot.define do
  factory :post do
    association :user
    sequence(:title) { |n| "post-test-#{n}" }
  end
end
