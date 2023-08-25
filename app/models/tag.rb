# == Schema Information
#
# Table name: tags
#
#  id   :bigint           not null, primary key
#  name :string
#
class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: { message: 'Enter tag name!' }, uniqueness: { message: 'Tag already exist!' }
end
