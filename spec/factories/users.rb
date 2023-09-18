FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user-test-#{n}" }
    sequence(:email) { |n| "test-#{n}@sample.com" }
    password { '123456' }

    trait :admin do
      role { :admin }
    end

    trait :banned do
      status { :banned }
    end
  end
end
