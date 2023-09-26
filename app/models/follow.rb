class Follow < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id, counter_cache: :followings_count
end
