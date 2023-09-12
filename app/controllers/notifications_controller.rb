class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user: current_user)
                                 .includes({ notificationable: %i[user post] })
                                 .order(id: :desc)

    if %w[Comment Post Reaction].include?(params[:type])
      @notifications = @notifications.where(notificationable_type: params[:type])
    end

    @notifications.unviewed.update_all(viewed: true)
    @unviewed_notifications_count = Notification.where(user: current_user).unviewed.count

    @pagy, @notifications = pagy(@notifications, items: 10)
  end
end
