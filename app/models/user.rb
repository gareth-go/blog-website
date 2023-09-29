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
         :validatable,
         :omniauthable,
         omniauth_providers: %i[google_oauth2]

  has_many :posts
  has_many :reactions
  has_many :comments
  has_many :notifications

  has_many :follows, inverse_of: :user, dependent: :destroy
  has_many :followers, through: :follows

  has_many :followings, inverse_of: :follower, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_users, through: :followings, source: :user

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

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) &&
         session['devise.facebook_data']['extra']['raw_info'] &&
         user.email.blank?
        user.email = data['email']
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name.split('@')[0]
    end
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
