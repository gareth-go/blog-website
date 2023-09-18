FactoryBot.define do
  factory :reaction do
    association :user
    association :post
    reaction_type { %i[like unicorn exploding_head raised_hand fire].sample }
  end
end
