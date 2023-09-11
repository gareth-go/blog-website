class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user: current_user)
                                 .includes({ notificationable: %i[user post] })
                                 .order(id: :desc)

    @notifications = @notifications.where(notificationable_type: params[:type]) if params[:type] == 'Comment' ||
                                                                                   params[:type] == 'Post' ||
                                                                                   params[:type] == 'Reaction'

    @notifications.unviewed.update(viewed: true)
    @unviewed_notifications_count = Notification.where(user: current_user).unviewed.count

    @pagy, @notifications = pagy(@notifications, items: 10)
  end
end
