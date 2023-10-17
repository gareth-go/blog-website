require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  describe '#empty_list' do
    context 'with no filer (reading list is empty)' do
      it 'displays "Your reading list is empty" message' do
        result = helper.empty_list(false)
        expect(result).to have_selector('div.pt-3 h4.text-center', text: 'Your reading list is empty')
      end

      it 'displays instructions to add posts to the reading list' do
        result = helper.empty_list(false)
        expect(result).to have_selector('div.pt-3 p.text-secondary.text-center', text: /Click the bookmark reaction when viewing a post to add it to your reading list/)
      end
    end

    context 'with filter (no posts match the filter)' do
      it 'displays "Nothing with this filter" message' do
        result = helper.empty_list(true)
        expect(result).to have_selector('div.pt-3 h4.text-center', text: 'Not thing with this filter')
      end

      it 'displays instructions to add posts to the reading list' do
        result = helper.empty_list(true)
        expect(result).to have_selector('div.pt-3 p.text-secondary.text-center', text: /Click the bookmark reaction when viewing a post to add it to your reading list/)
      end
    end
  end
end
