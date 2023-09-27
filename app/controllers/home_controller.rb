class HomeController < ApplicationController
  def index
    @posts = Post.where(status: Post.statuses[:accepted])
                 .includes({ user: { avatar_attachment: :blob } }, :tags)
    @posts = Posts::ListPostsService.call(@posts, params, current_user)
    # load cover image of first post
    @posts.first&.cover_image if params[:page].nil? || params[:page] == '1'

    @pagy, @posts = pagy(@posts)

    # get top 5 tags with most posts
    @tags = Tag.joins(:posts)
               .group('tags.id')
               .order('count(posts.id) desc')
               .limit(5)

    @top_interacted_tags = Tag.joins(:posts)
                              .select('tags.*, SUM(posts.comments_count + posts.reactions_count) AS interactions')
                              .group('tags.id')
                              .order('interactions DESC')
                              .limit(3)
  end
end
