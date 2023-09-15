require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:reactions) }
    it { should have_many(:comments) }
    it { should have_many(:notifications) }
    it { should have_one_attached(:avatar) }
  end

  describe 'validations' do
    it { should define_enum_for(:role).with_values(%i[normal_user admin]) }
    it { should define_enum_for(:status).with_values(%i[banned active]) }
    it { should validate_presence_of(:username).with_message('Please enter username!') }
    it { should validate_uniqueness_of(:username).with_message('User name have been used!') }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe '#active_for_authentication?' do
    context 'when user is active' do
      it 'return true' do
        expect(subject.active_for_authentication?).to be_truthy
      end
    end

    context 'when user is banned' do
      subject { build(:user, :banned) }

      it 'return false' do
        expect(subject.active_for_authentication?).to be_falsey
      end
    end
  end

  describe '#add_default_avatar' do
    context 'after create a new user' do
      subject { create(:user) }

      it 'attaches avatar for the user' do
        expect(subject.avatar.attached?).to be_truthy
      end
    end
  end
end
