class NotifyJob
  include Sidekiq::Job

  def perform(id)
    notification = Notification.find(id)

    alert = ApplicationController.render(partial: 'notifications/alert',
                                         locals: { notification: notification },
                                         formats: [:html])
    ActionCable.server.broadcast "notifications:#{notification.user_id}", alert
  end
end
