module Notifications
  class NotifyToFollowerService < ApplicationService
    def initialize(post) 
      @post = post
    end

    def call
      @post.user.followers.each do |user|
        Notification.create(user: user, notificationable: @post, content: 'published a post')
      end
    end
  end
end
