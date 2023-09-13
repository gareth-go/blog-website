require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post_record) { FactoryBot.create(:post) }
  let(:valid_attributes) { attributes_for(:post) }
  let(:invalid_attributes) { { title: '' } }

  shared_examples 'user do unauthorize action' do |action|
    it 'redirects to root path' do
      get action, params: { id: post_record.id } if %i[show edit].include?(action)
      put action, params: { id: post_record.id } if %i[accept reject].include?(action)
      delete action, params: { id: post_record.id } if action == :destroy

      should redirect_to root_path
      should set_flash[:alert]
    end
  end

  describe 'GET #show' do
    context 'user can not see un-accepted post of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :show
    end
  end

  describe 'GET #edit' do
    context 'user can not edit post of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :edit
    end
  end

  describe 'POST #create' do
    before { login_user }

    context 'with valid params' do
      it 'creates a new post' do
        expect do
          post :create, params: { post: valid_attributes }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        post :create, params: { post: valid_attributes }
        should redirect_to Post.last
      end
    end

    context 'with invalid params' do
      it 'does not create a new post' do
        expect do
          post :create, params: { post: invalid_attributes }
        end.not_to change(Post, :count)
      end

      it "render 'new' template" do
        post :create, params: { post: invalid_attributes }
        should render_template 'new'
      end
    end
  end

  describe 'PUT #update' do
    before { login_user }

    let(:post_record) { FactoryBot.create(:post, user: controller.current_user) }

    context 'with valid params' do
      let(:new_attributes) { { title: 'new title' } }

      it 'updates the post' do
        put :update, params: { id: post_record.id, post: new_attributes }
        post_record.reload
        expect(post_record.title).to eq('new title')
      end

      it 'redirects to the updated post' do
        put :update, params: { id: post_record.id, post: new_attributes }
        post_record.reload
        should redirect_to post_record
      end
    end

    context 'with invalid params' do
      it 'does not update the post' do
        put :update, params: { id: post_record.id, post: invalid_attributes }
        post_record.reload
        expect(post_record.title).not_to eq('')
      end

      it "render 'edit' template" do
        put :update, params: { id: post_record.id, post: invalid_attributes }
        should render_template 'edit'
      end
    end
  end

  describe 'PUT #accept' do
    context 'user are not authorize to accept post' do
      before { login_user }

      include_examples 'user do unauthorize action', :accept
    end

    context 'admin accept post success' do
      before { login_admin }

      it 'update post status to accepted' do
        put :accept, params: { id: post_record.id }
        expect(post_record.reload.status).to eq('accepted')
      end
    end
  end

  describe 'PUT #reject' do
    context 'user are not authorize to reject post' do
      before { login_user }

      include_examples 'user do unauthorize action', :reject
    end

    context 'admin reject post success' do
      before { login_admin }

      it 'update post status to rejected' do
        put :reject, params: { id: post_record.id }
        expect(post_record.reload.status).to eq('rejected')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user can not delete post of other user' do
      before { login_user }

      include_examples 'user do unauthorize action', :destroy
    end

    context 'user delete own post success' do
      before { login_user }

      let(:post_record) { FactoryBot.create(:post, user: controller.current_user) }

      it 'delete post' do
        delete :destroy, params: { id: post_record.id }
        expect(Post.exists?(post_record.id)).to eq(false)
      end
    end
  end
end
