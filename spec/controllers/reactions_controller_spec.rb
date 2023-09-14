require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  let(:post_record) { create(:post) }
  let(:reaction) { create(:reaction, post: post_record) }
  let(:valid_reaction_type) { attributes_for(:reaction)[:reaction_type] }
  let(:invalid_reaction_type) { :invalid_type }

  before { login_user }

  shared_examples 'create new reaction with valid reaction type' do
    it 'create new reaction' do
      expect do
        post :create, params: params, format: :js
      end.to change(Reaction, :count).by(1)
    end
  end

  describe 'POST #create' do
    context 'with valid reaction type' do
      let(:params) do
        {
          post_id: post_record.id,
          reaction_type: valid_reaction_type
        }
      end

      context 'user react is owner of the post' do
        let(:post_record) { create(:post, user: controller.current_user) }

        include_examples 'create new reaction with valid reaction type'

        it 'not create new notification' do
          expect do
            post :create, params: params, format: :js
          end.not_to change(Notification, :count)
        end
      end

      context 'user react is not owner of the post' do
        include_examples 'create new reaction with valid reaction type'

        it 'create new notification' do
          expect do
            post :create, params: params, format: :js
          end.to change(Notification, :count).by(1)
        end
      end
    end

    context 'with invalid reaction type' do
      let(:params) do
        {
          post_id: post_record.id,
          reaction_type: invalid_reaction_type
        }
      end

      it 'not create new reaction' do
        expect do
          post :create, params: params, format: :js
        end.not_to change(Reaction, :count)
      end

      it 'redirects to current post' do
        post :create, params: params, format: :js
        should redirect_to post_record
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid reaction type' do
      let(:new_reaction_type) { attributes_for(:reaction)[:reaction_type] }
      let(:params) do
        {
          post_id: post_record.id,
          id: reaction.id,
          reaction_type: new_reaction_type
        }
      end

      it 'update reaction type of the reaction' do
        put :update, params: params, format: :js
        reaction.reload
        expect(reaction.reaction_type).to eq(new_reaction_type.to_s)
      end
    end

    context 'with invalid reaction type' do
      let(:params) do
        {
          post_id: post_record.id,
          id: reaction.id,
          reaction_type: invalid_reaction_type
        }
      end

      before do
        put :update, params: params, format: :js
      end

      it 'not update reaction type of the reaction' do
        reaction.reload
        expect(reaction.reaction_type).not_to eq(invalid_reaction_type.to_s)
      end

      it 'redirects to current post' do
        should redirect_to post_record
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'delete reaction' do
      delete :destroy, params: { post_id: post_record.id, id: reaction.id }, format: :js
      expect(Reaction.exists?(reaction.id)).to eq(false)
    end
  end
end
