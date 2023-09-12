# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  commentable_type :string
#  commentable_id   :bigint
#  content          :text
#  created_at       :datetime
#
class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
  belongs_to :parent_comment, class_name: 'Comment', counter_cache: :replies_count, optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_comment_id', dependent: :destroy
  has_many :notifications, as: :notificationable, dependent: :destroy

  validates :content, presence: { message: 'Comment can not be blank!' }
end
