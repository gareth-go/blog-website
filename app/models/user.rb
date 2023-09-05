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
  enum status: { banned: 0, active: 1 }, _default: 'active'

  validates :username,
            presence: { message: 'Please enter username!' },
            uniqueness: { message: 'User name have been used!' }

  after_create_commit :add_default_avatar

  def active_for_authentication?
    # Uncomment the below debug statement to view the properties of the returned
    # self model values.
    # logger.debug self.to_yaml
    super && active?
  end

  private

  def add_default_avatar
    seed = rand(100)

    uri = URI("https://api.dicebear.com/7.x/identicon/png?seed=#{seed}")
    response = Net::HTTP.get(uri)

    avatar.attach(io: StringIO.new(response),
                  filename: 'default_avatar.png',
                  content_type: 'image/png')
  end
end
