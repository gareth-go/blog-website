require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post) { FactoryBot.create(:post) }

  describe 'Show' do
    context 'user can not see un-accepted post of other user' do
      before { login_user }

      it do
        get :edit, params: { id: post.id }

        should redirect_to root_path
        should set_flash[:alert]
      end
    end
  end

  describe 'Edit' do
    context 'user can not edit post of other user' do
      before { login_user }

      it do
        get :edit, params: { id: post.id }

        should redirect_to root_path
        should set_flash[:alert]
      end
    end
  end

  describe 'Accept' do
    context 'user are not authorize to accept post' do
      before { login_user }

      it do
        put :accept, params: { id: post.id }

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'admin accept post success' do
      before { login_admin }

      it do
        put :accept, params: { id: post.id }

        expect(post.reload.status).to eq('accepted')
      end
    end
  end

  describe 'Reject' do
    context 'user are not authorize to reject post' do
      before { login_user }

      it do
        put :reject, params: { id: post.id }

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'admin reject post success' do
      before { login_admin }

      it do
        put :reject, params: { id: post.id }

        expect(post.reload.status).to eq('rejected')
      end
    end
  end

  describe 'Delete' do
    context 'user can not delete post of other user' do
      before { login_user }

      it do
        delete :destroy, params: { id: post.id }

        should redirect_to root_path
        should set_flash[:alert]
      end
    end

    context 'delete post success' do
      before { login_user }

      it do
        post = FactoryBot.create(:post, user: controller.current_user)
        delete :destroy, params: { id: post.id }

        expect(Post.exists?(post.id)).to eq(false)
      end
    end
  end
end
