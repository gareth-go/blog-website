FactoryBot.define do
  factory :notification do
    association :user

    trait :post_notification do
      notificationable { association :post }
    end

    trait :comment_notification do
      notificationable { association :comment }
    end

    trait :reaction_notification do
      notificationable { association :reaction }
    end
  end
end
