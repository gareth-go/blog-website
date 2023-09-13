require 'rails_helper'

RSpec.describe Dashboard::TagsController, type: :controller do
  let(:tag) { create(:tag) }
  let(:valid_attributes) { attributes_for(:tag) }
  let(:invalid_attributes) { { name: '' } }

  shared_examples 'user do unauthorize action' do |action|
    it 'redirects to root path' do
      case action
      when :index
        get action
      when :create
        post action, params: { tag: valid_attributes }, format: :js
      when :update
        put action, params: { id: tag.id, tag: valid_attributes }, format: :js
      when :destroy
        delete action, params: { id: tag.id }, format: :js
      end

      should redirect_to root_path
      should set_flash[:alert]
    end
  end

  describe 'GET #index' do
    context 'current user not admin' do
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

  describe 'POST #create' do
    context 'current user is not admin' do
      before { login_user }

      include_examples 'user do unauthorize action', :create
    end

    context 'current user is admin' do
      before { login_admin }

      context 'with valid params' do
        it 'creates new tag' do
          expect do
            post :create, params: { tag: valid_attributes }, format: :js
          end.to change(Tag, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'does not create new tag' do
          expect do
            post :create, params: { tag: invalid_attributes }, format: :js
          end.not_to change(Tag, :count)
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'current user is not admin' do
      before { login_user }

      include_examples 'user do unauthorize action', :update
    end

    context 'current user is admin' do
      before { login_admin }

      context 'with valid params' do
        let(:new_attributes) { { name: 'new tag name' } }

        it 'update tag' do
          put :update, params: { id: tag.id, tag: new_attributes }, format: :js
          expect(tag.reload.name).to eq('new tag name')
        end
      end

      context 'with invalid params' do
        it 'does not update tag' do
          put :update, params: { id: tag.id, tag: invalid_attributes }, format: :js
          expect(tag.reload.name).not_to eq('')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'current user is not admin' do
      before { login_user }

      include_examples 'user do unauthorize action', :destroy
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
