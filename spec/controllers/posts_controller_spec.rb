require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post_record) { FactoryBot.create(:post, status: :pending) }
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

  shared_examples 'notify when admin browse post' do |action|
    it 'create new notification' do
      expect do
        put action, params: { id: post_record.id }
      end.to change(Notification, :count).by_at_least(1)
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

  describe 'PUT #publish' do
    let(:post_record) { FactoryBot.create(:post, user: controller.current_user, status: :drafting) }

    before { login_user }

    context 'with valid params' do
      it 'publish a new post' do
        put :publish, params: { id: post_record.id, post: valid_attributes }
        expect(post_record.reload.status).to eq('pending')
      end

      it 'redirects to the published post' do
        put :publish, params: { id: post_record.id, post: valid_attributes }
        should redirect_to post_record
      end
    end

    context 'with invalid params' do
      it 'does not publish a new post' do
        put :publish, params: { id: post_record.id, post: invalid_attributes }
        expect(post_record.reload.status).not_to eq('pending')
      end

      it "render 'new' template" do
        put :publish, params: { id: post_record.id, post: invalid_attributes }
        should render_template 'new'
      end
    end
  end

  describe 'PUT #update' do
    before { login_user }

    let(:post_record) { FactoryBot.create(:post, user: controller.current_user, status: :accepted) }

    context 'with valid params' do
      let(:new_attributes) { { title: 'new title' } }

      before do
        put :update, params: { id: post_record.id, post: new_attributes }
      end

      it 'updates the post' do
        post_record.reload
        expect(post_record.title).to eq('new title')
      end

      it 'redirects to the updated post' do
        post_record.reload
        should redirect_to post_record
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: post_record.id, post: invalid_attributes }
      end

      it 'does not update the post' do
        post_record.reload
        expect(post_record.title).not_to eq('')
      end

      it "render 'edit' template" do
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

      include_examples 'notify when admin browse post', :accept
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

      include_examples 'notify when admin browse post', :reject
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
        request.headers['HTTP_REFERER'] = post_path(post_record)
        delete :destroy, params: { id: post_record.id }
        expect(Post.exists?(post_record.id)).to eq(false)
      end
    end
  end
end
