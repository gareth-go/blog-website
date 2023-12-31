require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:post_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:post_tags) }
    it { should have_many(:reactions).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values(%i[pending accepted rejected drafting]) }

    context 'when post is not in drafting status' do
      subject { create(:post, status: :pending) }

      it { should validate_presence_of(:title).with_message('Title can not be blank') }
      it { should validate_uniqueness_of(:title).with_message('This title is already exist') }
    end

    context 'when post is in drafting status' do
      subject { create(:post, status: :drafting) }

      it { should_not validate_presence_of(:title).with_message('Title can not be blank') }
      it { should_not validate_uniqueness_of(:title).with_message('This title is already exist') }
    end
  end

  describe 'active storage' do
    it { should have_one_attached(:cover_image) }
    it { should have_rich_text(:content) }
  end
end
