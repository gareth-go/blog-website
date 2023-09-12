FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user-test-#{n}" }
    sequence(:email) { |n| "test-#{n}@sample.com" }
    password { '123456' }

    factory :admin do
      after(:create) { |user| user.update(role: :admin) }
    end
  end
end
