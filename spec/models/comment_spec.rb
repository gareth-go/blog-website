require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).counter_cache(true) }
    it { should belong_to(:post).counter_cache(true) }
    it { should belong_to(:parent_comment).class_name('Comment').counter_cache(:replies_count).optional(true) }
    it { should have_many(:replies).class_name('Comment').dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content).with_message('Comment can not be blank!') }
  end
end
