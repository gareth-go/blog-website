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
require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
