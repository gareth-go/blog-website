require 'rails_helper'

RSpec.describe Settings::ProfileController, type: :controller do
  let(:user) { create(:user) }

  shared_examples 'user do unauthorize action' do |action|
    it 'redirects to root path' do
      get action, params: { username: user.username } if action == :edit
      put action, params: { username: user.username } if action == :update

      should redirect_to root_path
      should set_flash[:alert]
    end
  end

  shared_examples 'fail to update profile' do |new_user, new_email|
    before { put :update, params: params }

    it 'not updates user profile' do
      user.reload
      expect(user.username).not_to eq(new_user)
      expect(user.email).not_to eq(new_email)
    end

    it "renders 'edit' template" do
      should render_template 'edit'
    end
  end

  describe 'GET #edit' do
    context 'user edit profile of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :edit
    end

    context 'user edit own profile' do
      before { sign_in user }

      it 'success response' do
        get :edit, params: { username: user.username }
        should respond_with :success
      end
    end
  end

  describe 'PUT #update' do
    context 'user update profile of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :edit
    end

    context 'user update own profile' do
      before { sign_in user }

      context 'with valid params' do
        let(:params) do
          {
            username: user.username,
            user: {
              username: 'new_username',
              email: 'new_email@gmail.com'
            }
          }
        end

        before { put :update, params: params }

        it 'updates user profile' do
          user.reload
          expect(user.username).to eq('new_username')
          expect(user.email).to eq('new_email@gmail.com')
        end

        it 'reload the page' do
          user.reload
          should redirect_to edit_settings_profile_path(user.username)
        end
      end

      context 'with invalid username' do
        let(:params) do
          {
            username: user.username,
            user: {
              username: '',
              email: 'new_email@gmail.com'
            }
          }
        end

        include_examples 'fail to update profile', '', 'new_email@gmail.com'
      end

      context 'with invalid email' do
        let(:params) do
          {
            username: user.username,
            user: {
              username: 'new_username',
              email: 'new_email'
            }
          }
        end

        include_examples 'fail to update profile', 'new_username', 'new_email'
      end
    end
  end
end
