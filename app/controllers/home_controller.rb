class HomeController < ApplicationController
  def index
    # include both cover_image_attachment and blob if it is first page
    # include only cover_image_attachment if it is not first page to avoid n + 1
    @posts = Post.where(status: Post.statuses[:accepted]).order(created_at: :desc).includes(%i[user tags])
    @posts = @posts.with_attached_cover_image if params[:page] == '1' || !params[:page].present?
    @posts = @posts.includes([:cover_image_attachment]) if params[:page].present? && params[:page].to_i > 1

    @pagy, @posts = pagy(@posts)

    # get top 5 tags with most posts
    @tags = Tag.joins(:posts).group('tags.id').order('count(posts.id) desc').limit(5)
  end
end
