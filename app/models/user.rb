# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  username               :string
#  email                  :string           default(""), not null
#  role                   :integer
#  status                 :integer
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :posts
  has_many :reactions
  has_many :comments
  has_many :notifications

  has_one_attached :avatar

  enum role: { normal_user: 0, admin: 1 }, _default: 'normal_user'
  enum status: { baned: 0, active: 1 }, _default: 'active'

  validates :username,
            presence: { message: 'Please enter username!' },
            uniqueness: { message: 'User name have been used!' }

  after_create_commit :add_default_avatar

  private

  def add_default_avatar
    avatar.attach(io: File.open(Rails.root.join('app', 'javascript', 'images', 'avatar.png')),
                  filename: 'avatar.png',
                  content_type: 'image/png')
  end
end
