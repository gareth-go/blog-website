# == Schema Information
#
# Table name: users
#
#  id       :bigint           not null, primary key
#  username :string
#  password :string
#  email    :string
#  role     :integer
#  status   :integer
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
