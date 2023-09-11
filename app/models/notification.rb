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

  private

  def sent_message
    alert = ApplicationController.render partial: 'notifications/alert', locals: { notification: self }, formats: [:html]
    ActionCable.server.broadcast "notifications:#{user_id}", alert
  end
end
