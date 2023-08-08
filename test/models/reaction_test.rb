# == Schema Information
#
# Table name: reactions
#
#  id            :bigint           not null, primary key
#  user_id       :bigint
#  post_id       :bigint
#  reaction_type :integer
#  created_at    :datetime
#
require "test_helper"

class ReactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
