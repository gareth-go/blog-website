require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, post: post) }

  describe '#menu_if_owner_or_admin' do
    context 'when the user is the owner of the post or has destroy policy' do
      before { sign_in user }

      before do
        allow(helper).to receive(:policy).with(comment).and_return(double(destroy?: true))
      end

      it 'renders the comment menu' do
        expect(helper).to receive(:render).with('comments/comment_menu', comment: comment)
        helper.menu_if_owner_or_admin(user, post, comment)
      end

      context 'when the comment has a parent comment' do
        before do
          allow(comment).to receive(:parent_comment).and_return(create(:comment))
        end

        it 'renders the reply menu' do
          expect(helper).to receive(:render).with(partial: 'comments/reply_menu', locals: { parent_comment: comment.parent_comment, reply: comment })
          helper.menu_if_owner_or_admin(user, post, comment)
        end
      end
    end

    context 'when the user is not the owner of the post and does not have destroy policy' do
      let(:post) { create(:post) }

      before { login_user }

      it 'does not render any menu' do
        expect(helper.menu_if_owner_or_admin(user, post, comment)).to be_nil
      end
    end
  end
end
