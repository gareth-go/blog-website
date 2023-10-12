require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#share_button' do
    let(:post_record) { create(:post) }

    it 'returns the expected HTML structure' do
      url = post_url(post_record)
      text = 'post'

      button = helper.share_button(url, text)

      expect(button).to have_selector('div.btn-group')
      expect(button).to have_selector('li > div', text: "Copy #{text} link")
      expect(button).to have_selector("li > a[href$='sharer.php?u=#{url}']", text: "Share #{text} to Facebook")
      expect(button).to have_selector("li > a[href$='tweet?url=#{url}']", text: "Share #{text} to Twitter")
    end
  end
end
