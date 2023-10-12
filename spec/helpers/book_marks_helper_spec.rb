require 'rails_helper'

RSpec.describe BookMarksHelper, type: :helper do
  let(:post_record) { create(:post) }

  describe '#link_to_bookmark' do
    context 'when the method is :post' do
      let(:path) { book_marks_path(post_id: @post.id) }

      it 'renders a bookmark link with the save icon' do
        expected_icon_path = %r{media/images/save-icon\.svg}

        link = helper.link_to_bookmark(path, :post)

        expect(link).to have_selector('div.bookmark-button')
        expect(link).to have_selector("a[href='#{path}'][method='post'][data-remote='true']")
        expect(link).to have_selector("img[src^='#{expected_icon_path}']")
      end
    end

    context 'when the method is not :post' do
      let(:path) { book_mark_path(@book_mark) }

      it 'renders a bookmark link with the unsave icon' do
        expected_icon_path = %r{media/images/unsave-icon\.svg}

        link = helper.link_to_bookmark(path, :delete)

        expect(link).to have_selector('div.bookmark-button')
        expect(link).to have_selector("a[href='#{path}'][method='delete'][data-remote='true']")
        expect(link).to have_selector("img[src^='#{expected_icon_path}']")
      end
    end
  end

end
