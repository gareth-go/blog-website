require 'rails_helper'

RSpec.describe NotificationsHelper, type: :helper do
  describe '#link_to_notificationable' do
    context 'when the notificationable_type is "Post"' do
      it 'generates a link to the Post' do
        notification = create(:notification, :post_notification)
        alert = true

        link = helper.link_to_notificationable(notification, alert)

        expect(link).to have_link(notification.content, href: post_path(notification.notificationable))
      end
    end

    context 'when the notificationable_type is "Comment"' do
      it 'generates a link to the Comment within the Post' do
        notification = create(:notification, :comment_notification)
        alert = true

        link = helper.link_to_notificationable(notification, alert)

        expect(link).to have_link(notification.content, href: post_path(notification.notificationable.post) + "#comment-#{notification.notificationable.id}")
      end
    end

    context 'when the notificationable_type is "Reaction"' do
      it 'generates a link to the Comment within the Post' do
        notification = create(:notification, :reaction_notification)
        alert = true

        link = helper.link_to_notificationable(notification, alert)

        expect(link).to have_link(notification.content, href: post_path(notification.notificationable.post))
      end
    end
  end
end
