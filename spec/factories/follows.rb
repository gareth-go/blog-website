FactoryBot.define do
  factory :follow do
    assocciation :user
    assocciation :follower, factory: :user
  end
end
