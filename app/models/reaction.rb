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
class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum reaction_type: %i[like love laugh wow sad angry]
end
