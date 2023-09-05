class HomeController < ApplicationController
  def index
    @posts = Post.where(status: Post.statuses[:accepted])
                 .order(created_at: :desc)
                 .includes({ user: { avatar_attachment: :blob } }, :tags, :cover_image_attachment)
    @posts = Posts::PostsFilterService.call(@posts, params)

    @pagy, @posts = pagy(@posts)

    # get top 5 tags with most posts
    @tags = Tag.joins(:posts)
               .group('tags.id')
               .order('count(posts.id) desc')
               .limit(5)
  end
end
