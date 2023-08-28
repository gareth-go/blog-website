class Dashboard::PostsController < ApplicationController
  def index
    @posts = if current_user.admin?
               Post.all.order(created_at: :desc).includes(%i[user tags])
             else
               current_user.posts.order(created_at: :desc).includes(%i[tags])
             end

    @posts = @posts.where(status: Post.statuses[params[:status]]) if params[:status] &&
                                                                     Post.statuses.include?(params[:status])
  end
end
