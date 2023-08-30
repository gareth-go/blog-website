class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = if current_user.admin?
               Post.all
                   .order(created_at: :desc)
                   .includes({ user: { avatar_attachment: :blob } }, :tags)
             else
               current_user.posts
                           .order(created_at: :desc)
                           .includes(%i[tags])
             end

    @posts = @posts.where(status: Post.statuses[params[:status]]) if params[:status] &&
                                                                     Post.statuses.include?(params[:status])

    @pagy, @posts = pagy(@posts)
  end
end
