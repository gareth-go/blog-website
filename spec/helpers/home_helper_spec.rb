require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  let(:page) { 1 }
  let(:post) { create(:post) }
  let(:is_first_posts) { true }

  before do
    uri = URI('https://api.dicebear.com/7.x/identicon/png?seed=1')
    response = Net::HTTP.get(uri)

    post.cover_image.attach(io: StringIO.new(response),
                            filename: 'default_avatar.png',
                            content_type: 'image/png')
  end

  describe '#cover_image_if_first_post' do
    context 'when on the home page and it is the first post' do
      before do
        allow(helper).to receive(:controller_name).and_return('home')
        allow(post.cover_image).to receive(:attached?).and_return(true)
      end

      it 'returns the cover image tag' do
        expect(helper.cover_image_if_first_post(page, post, is_first_posts)).to eq(image_tag(post.cover_image, class: 'w-100 rounded-top shadow-sm'))
      end
    end

    context 'when not on the home page or it is not the first post' do
      let(:page) { 2 }
      let(:is_first_posts) { false }

      it 'returns nil' do
        expect(helper.cover_image_if_first_post(page, post, is_first_posts)).to be_nil
      end
    end
  end
end
