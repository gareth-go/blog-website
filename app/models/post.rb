# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string
#  content     :text
#  cover_image :string
#  created_at  :datetime
#  user_id     :bigint
#  status      :integer
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :reactions
  has_many :comments, as: :commentable

  enum status: { pending: 0, accepted: 1, rejected: 2, deleted: 3 }, _default: 'pending'

  has_rich_text :content
  has_one_attached :cover_image
  
end
