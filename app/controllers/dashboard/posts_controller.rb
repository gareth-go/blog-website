class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = if current_user.admin?
               Post.all
                   .order(created_at: :desc)
                   .includes({ user: { avatar_attachment: :blob } }, :tags, :reactions)
             else
               current_user.posts
                           .order(created_at: :desc)
                           .includes(%i[tags reactions])
             end

    @posts = @posts.where.not(status: :drafting)
    @posts = Posts::ListPostsService.call(@posts, params)

    @posts_count = @posts.count

    @pagy, @posts = pagy(@posts)
  end
end
