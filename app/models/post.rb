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
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :reactions, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { pending: 0, accepted: 1, rejected: 2 }, _default: 'pending'

  has_rich_text :content
  has_one_attached :cover_image

  validates :title, presence: { message: 'Title can not be blank' }
end
