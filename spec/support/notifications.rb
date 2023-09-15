module Notifications
  def test_notification_creation(expectation, action, params, format = :html, change_by = 0)
    it "#{expectation} new notification" do
      expect do
        send(action, params, format: format)
      end.to change(Notification, :count).by(change_by)
    end
  end
end
