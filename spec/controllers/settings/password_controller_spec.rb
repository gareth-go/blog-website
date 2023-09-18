require 'rails_helper'

RSpec.describe Settings::PasswordController, type: :controller do
  let(:user) { create(:user) }

  shared_examples 'user do unauthorize action' do |action|
    it 'redirects to root path' do
      get action, params: { username: user.username } if action == :edit
      put action, params: { username: user.username } if action == :update

      should redirect_to root_path
      should set_flash[:alert]
    end
  end

  shared_examples 'fail to update the password' do |new_password|
    before { put :update, params: params }

    it 'not updates the password' do
      user.reload
      expect(user.valid_password?(new_password)).to be_falsey
    end

    it "renders 'edit' template" do
      should render_template 'edit'
    end
  end

  describe 'GET #edit' do
    context 'user edit password of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :edit
    end

    context 'user edit own password' do
      before { sign_in user }

      it 'success response' do
        get :edit, params: { username: user.username }
        should respond_with :success
      end
    end
  end

  describe 'PUT #update' do
    context 'user update password of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :update
    end

    context 'user update own password' do
      before { sign_in user }

      context 'with valid params' do
        let(:params) do
          {
            username: user.username,
            user: {
              old_password: '123456',
              password: 'new_password',
              password_confirmation: 'new_password'
            }
          }
        end

        before { put :update, params: params }

        it 'updates the password' do
          user.reload
          expect(user.valid_password?('new_password')).to be_truthy
        end

        it 'reloads the page' do
          should redirect_to edit_settings_password_path(user.username)
        end
      end

      context 'with wrong old password' do
        let(:params) do
          {
            username: user.username,
            user: {
              old_password: '645321',
              password: 'new_password',
              password_confirmation: 'new_password'
            }
          }
        end

        include_examples 'fail to update the password', 'new_password'
      end

      context 'with invalid password' do
        let(:params) do
          {
            username: user.username,
            user: {
              old_password: '645321',
              password: '',
              password_confirmation: ''
            }
          }
        end

        include_examples 'fail to update the password', ''
      end

      context 'with wrong pass confirmation' do
        let(:params) do
          {
            username: user.username,
            user: {
              old_password: '645321',
              password: 'new_password',
              password_confirmation: 'new_pass'
            }
          }
        end

        include_examples 'fail to update the password', 'new_password'
      end
    end
  end
end
