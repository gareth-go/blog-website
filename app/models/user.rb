# == Schema Information
#
# Table name: users
#
#  id       :bigint           not null, primary key
#  username :string
#  password :string
#  email    :string
#  role     :integer
#  status   :integer
#
class User < ApplicationRecord
  has_many :posts
  has_many :reactions
  has_many :comments
  has_many :notifications

  enum role: %i[normal_user admin], _default: 'normal_user'
  enum status: %i[baned active], _default: 'active'
end
