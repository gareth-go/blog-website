module Notifications
  class CreateNotificationService < ApplicationService
    def initialize(user, notificationable, notification_type)
      @user = user
      @notification_type = notification_type
      @notificationable = notificationable
    end

    def call
      return if user_is_notificationable_owner

      Notification.create(user: @user, notificationable: @notificationable, content: notification_content)
    end

    private

    def user_is_notificationable_owner
      return true if @notification_type != 'post' && @user == @notificationable.user

      false
    end

    def notification_content
      case @notification_type
      when 'post'
        return 'Your post was accepted by admin.' if @notificationable.accepted?

        'Your post was rejected by admin.'

      when 'reaction'
        'reacted to your post'

      when 'comment'
        return 'replied to your comment.' if @notificationable.parent_comment.present?

        'commented to your post.'
      end
    end
  end
end
