module NotificationsHelper
  def link_to_notificationable(notification, alert)
    path = if alert
             'notifications/alert_message'
           else
             'notification'
           end

    if notification.notificationable_type == 'Post'
      return link_to(post_path(notification.notificationable),
                     class: 'text-decoration-none text-reset') do
               render path, notification: notification
             end
    end

    if notification.notificationable_type == 'Comment'
      return link_to(post_path(notification.notificationable.post) + "#comment-#{notification.notificationable_id}",
                     class: 'text-decoration-none text-reset') do
               render path, notification: notification
             end
    end

    link_to(post_path(notification.notificationable.post),
            class: 'text-decoration-none text-reset') do
      render path, notification: notification
    end
  end
end
