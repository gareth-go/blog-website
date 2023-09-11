require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'Create post' do
    10.times.each do
      it do
        sign_in :user

        params = {
          post: {
            title: Faker::Lorem.unique.sentence,
            content: Faker::Lorem.paragraphs,
            tags: Tag.all.sample(4)
          }
        }

        should permit(:title, :cover_image, :content, tags: [])
          .for(:create, params: params)
          .on(:post)
      end
    end
  end
end
