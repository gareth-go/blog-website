require 'rails_helper'

RSpec.describe Dashboard::AccountsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  shared_examples 'user do unauthorize action' do |action|
    it 'redirects to root path' do
      get action if action == :index
      put action, params: { id: user.id }, format: :js if action == :update

      should redirect_to root_path
      should set_flash[:alert]
    end
  end

  describe 'GET #index' do
    context 'current user is not admin' do
      before { login_user }

      include_examples 'user do unauthorize action', :index
    end

    context 'current user is admin' do
      before { login_admin }

      it 'success response' do
        get :index
        should respond_with :success
      end
    end
  end

  describe 'GET #update' do
    context 'current user is not admin' do
      before { login_user }

      include_examples 'user do unauthorize action', :update
    end

    context 'current user is admin' do
      before { login_admin }

      context 'grant a user admin role' do
        it 'updates role of the user to admin' do
          put :update, params: { id: user.id, role: :admin }, format: :js
          user.reload
          expect(user.role).to eq('admin')
        end
      end

      context 'invoke admin role from an admin' do
        it 'updates role of the admin to normal_user' do
          put :update, params: { id: admin.id, role: :normal_user }, format: :js
          admin.reload
          expect(admin.role).to eq('normal_user')
        end
      end

      context 'with invalid role param' do
        it 'not updates role of user' do
          put :update, params: { id: user.id, role: :ambiguous_role }, format: :js
          user.reload
          expect(user.role).not_to eq('ambiguous_role')
        end
      end

      context 'ban an active user' do
        it 'update status of user to banned' do
          put :update, params: { id: user.id, status: :banned }, format: :js
          user.reload
          expect(user.status).to eq('banned')
        end
      end

      context 'unban a banned user' do
        let(:banned_user) { create(:user, :banned) }

        it 'update status of user to active' do
          put :update, params: { id: banned_user, status: :active }, format: :js
          banned_user.reload
          expect(banned_user.status).to eq('active')
        end
      end

      context 'with invalid status param' do
        it 'not update status of user' do
          put :update, params: { id: user.id, status: :ambiguous_status }, format: :js
          user.reload
          expect(user.status).not_to eq('ambiguous_status')
        end
      end
    end
  end
end
