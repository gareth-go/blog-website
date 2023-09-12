require 'rails_helper'

RSpec.describe Dashboard::TagsController, type: :controller do
  let(:tag) { create(:tag) }

  describe 'GET #index' do
    context 'current user not admin' do
      before { login_user }

      it 'redirects to root path' do
        get :index

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'current user is admin' do
      before { login_admin }

      it 'success response' do
        get :index

        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'current user is not admin' do
      before { login_user }

      it 'redirects to root path' do
        post :create, params: { tag: attributes_for(:tag) }, format: :js

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'current user is admin' do
      before { login_admin }

      it 'create a new tag' do
        expect do
          post :create, params: { tag: attributes_for(:tag) }, format: :js
        end.to change(Tag, :count).by(1)
      end
    end
  end

  describe 'PATCH #update' do
    context 'current user is not admin' do
      before { login_user }

      it 'redirects to root path' do
        put :update, params: { id: tag.id, tag: { name: 'new tag name' } }, format: :js

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'current user is admin' do
      before { login_admin }

      it 'update tag' do
        put :update, params: { id: tag.id, tag: { name: 'new tag name' } }, format: :js

        expect(tag.reload.name).to eq('new tag name')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'current user is not admin' do
      before { login_user }

      it 'redirects to root path' do
        delete :destroy, params: { id: tag.id }

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'current user is admin' do
      before { login_admin }

      it 'delete tag' do
        delete :destroy, params: { id: tag.id }, format: :js

        expect(Tag.exists?(tag.id)).to eq(false)
      end
    end
  end
end
