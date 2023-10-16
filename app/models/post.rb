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
  belongs_to :user, counter_cache: true

  has_many :book_marks, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notificationable, dependent: :destroy

  enum status: { pending: 0, accepted: 1, rejected: 2, drafting: 3 }, _default: 'drafting'

  has_rich_text :content
  has_one_attached :cover_image

  validate :title_presence_if_publish, :title_unique_if_publish

  private

  def title_presence_if_publish
    errors.add(:title, 'Title can not be blank') if !drafting? && title.blank?
  end

  def title_unique_if_publish
    errors.add(:title, 'This title is already exist') if !drafting? && Post.where.not(id: id).exists?(title: title)
  end
end
