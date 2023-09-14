require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post).counter_cache(true) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should define_enum_for(:reaction_type).with_values(%i[like unicorn exploding_head raised_hand fire]) }
  end
end
