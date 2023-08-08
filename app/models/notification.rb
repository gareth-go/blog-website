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
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificationable, polymorphic: true
end
