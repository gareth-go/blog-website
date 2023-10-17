FactoryBot.define do
  factory :book_mark do
    association :user
    association :post
  end
end
