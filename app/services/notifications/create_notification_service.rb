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
      notify_to_followers if @notification_type == 'post' && @notificationable.accepted?
    end

    private

    def user_is_notificationable_owner
      @notification_type != 'post' && @user == @notificationable.user
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

    def notify_to_followers
      @notificationable.user.followers.each do |user|
        Notification.create(user: user, notificationable: @notificationable, content: 'pushlished a post')
      end
    end
  end
end
