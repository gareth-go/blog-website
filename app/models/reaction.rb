# == Schema Information
#
# Table name: reactions
#
#  id            :bigint           not null, primary key
#  user_id       :bigint
#  post_id       :bigint
#  reaction_type :integer
#  created_at    :datetime
#
class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :notifications, as: :notificationable, dependent: :destroy

  enum reaction_type: { like: 0, unicorn: 1, exploding_head: 2, raised_hand: 3, fire: 4 }
end
