class HomeController < ApplicationController
  def index
    @posts = Post.where(status: Post.statuses[:accepted])
                 .includes({ user: { avatar_attachment: :blob } }, :tags)
    @posts = Posts::PostsFilterService.call(@posts, params)
    @posts = Posts::PostsSortService.call(@posts, params)
    # load cover image of first post
    @posts.first&.cover_image if params[:page].nil? || params[:page] == '1'

    @pagy, @posts = pagy(@posts)

    # get top 5 tags with most posts
    @tags = Tag.joins(:posts)
               .group('tags.id')
               .order('count(posts.id) desc')
               .limit(5)
  end
end
