# == Schema Information
#
# Table name: tags
#
#  id   :bigint           not null, primary key
#  name :string
#
class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags
end
