# == Schema Information
#
# Table name: notifications
#
#  id                    :bigint           not null, primary key
#  user_id               :bigint
#  notificationable_type :string
#  notificationable_id   :bigint
#  content               :text
#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificationable, polymorphic: true

  after_create_commit :sent_message

  scope :unviewed, -> { where(viewed: false) }

  def browse_post_notification?
    notificationable_type == 'Post' && notificationable.user == user
  end

  private

  def sent_message
    NotifyJob.perform_async(id)
  end
end
