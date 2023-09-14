FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag-test-#{n}" }
  end
end
