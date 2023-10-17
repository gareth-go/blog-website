require 'rails_helper'

RSpec.describe BookMarksHelper, type: :helper do
  let(:post_record) { create(:post) }
  let(:book_mark) { create(:book_mark) }

  describe '#link_to_bookmark' do
    context 'when the method is :post' do
      let(:path) { book_marks_path(post_id: post_record.id) }

      it 'renders a bookmark link with the save icon' do
        link = helper.link_to_bookmark(path, :post)

        expect(link).to have_selector('div.bookmark-button')
        expect(link).to have_selector("a[href='#{path}'][data-method='post'][data-remote='true']")
      end
    end

    context 'when the method is not :post' do
      let(:path) { book_mark_path(book_mark) }

      it 'renders a bookmark link with the unsave icon' do
        link = helper.link_to_bookmark(path, :delete)

        expect(link).to have_selector('div.bookmark-button')
        expect(link).to have_selector("a[href='#{path}'][data-method='delete'][data-remote='true']")
      end
    end
  end
end
