# == Schema Information
#
# Table name: post_tags
#
#  id      :bigint           not null, primary key
#  post_id :bigint
#  tag_id  :bigint
#
class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end
