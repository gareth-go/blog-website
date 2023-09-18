require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:post_record) { create(:post) }
  let(:comment) { create(:comment, post: post_record) }
  let(:valid_params) { { content: Faker::Lorem.paragraph } }
  let(:invalid_params) { { content: '' } }

  before { login_user }

  shared_examples 'user create new comment' do
    it 'creates new comment' do
      expect do
        post :create, params: params, format: :js
      end.to change(Comment, :count).by(1)
    end
  end

  shared_examples 'user create new reply' do
    it 'creates new reply' do
      expect do
        post :create, params: params, format: :js
        comment.reload
      end.to change { comment.replies.size }.by(1)
    end
  end

  shared_examples 'reload when comment with invalid params' do |action|
    it 'redirects to current post' do
      expect do
        case action
        when :create
          post action, params: params, format: :js
        when :update
          put action, params: params, format: :js
        end

        should redirect_to post_record
      end
    end
  end

  shared_examples 'notify when create new comment' do |expectation, change_by|
    it "#{expectation} new notification" do
      expect do
        post :create, params: params, format: :js
      end.to change(Notification, :count).by(change_by)
    end
  end

  shared_examples 'user do unauthorize action' do |action|
    it 'redirects to root path' do
      case action
      when :update
        put action, params: { id: comment.id, comment: valid_params }, format: :js
      when :destroy
        delete action, params: { id: comment.id }, format: :js
      end

      should redirect_to root_path
      should set_flash[:alert]
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      context 'comment to a post' do
        let(:params) do
          {
            post_id: post_record.id,
            comment: valid_params
          }
        end

        context 'user comment is owner of the post' do
          let(:post_record) { create(:post, user: controller.current_user) }

          include_examples 'user create new comment'

          include_examples 'notify when create new comment', 'not creates', 0
        end

        context 'user comment is not owner of the post' do
          include_examples 'user create new comment'

          include_examples 'notify when create new comment', 'creates', 1
        end
      end

      context 'reply to a comment' do
        let(:params) do
          {
            comment_id: comment.id,
            comment: valid_params
          }
        end

        context 'user reply is owner of the comment' do
          let(:comment) { create(:comment, post: post_record, user: controller.current_user) }

          include_examples 'user create new reply'

          include_examples 'notify when create new comment', 'not creates', 0
        end

        context 'user reply is not owner of the comment' do
          include_examples 'user create new reply'

          include_examples 'notify when create new comment', 'creates', 1
        end
      end
    end

    context 'with invalid params' do
      context 'comment to a post' do
        let(:params) do
          {
            post_id: post_record.id,
            comment: invalid_params
          }
        end

        it 'not creates new comment' do
          expect do
            post :create, params: params, format: :js
          end.not_to change(Comment, :count)
        end

        include_examples 'reload when comment with invalid params', :post
      end

      context 'reply to a comment' do
        let(:params) do
          {
            comment_id: comment.id,
            comment: invalid_params
          }
        end

        it 'not creates new reply' do
          expect do
            post :create, params: params, format: :js
            comment.reload
          end.not_to(change { comment.replies.size })
        end

        include_examples 'reload when comment with invalid params', :post
      end
    end
  end

  describe 'PUT #update' do
    context 'user update comment of other user' do
      include_examples 'user do unauthorize action', :update
    end

    context 'user update own comment' do
      let(:comment) { create(:comment, post: post_record, user: controller.current_user) }
      let(:params) do
        {
          id: comment.id,
          comment: valid_params
        }
      end

      context 'with valid params' do
        it 'updates the comment' do
          put :update, params: params, format: :js
          comment.reload
          expect(comment.content).to eq(valid_params[:content])
        end
      end

      context 'with invalid params' do
        let(:params) do
          {
            id: comment.id,
            comment: invalid_params
          }
        end

        it 'not updates the comment' do
          put :update, params: params, format: :js
          comment.reload
          expect(comment.content).not_to eq('')
        end

        include_examples 'reload when comment with invalid params', :update
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user delete comment of other user' do
      include_examples 'user do unauthorize action', :destroy
    end

    context 'user delete own comment' do
      let(:comment) { create(:comment, user: controller.current_user) }

      it 'delete the comment' do
        delete :destroy, params: { id: comment.id }, format: :js
        expect(Comment.exists?(comment.id)).to eq(false)
      end
    end
  end
end
