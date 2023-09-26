class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(id: :asc)

    @tags = @tags.where('name LIKE ?', "%#{params[:search_tags]}%") if params[:search_tags].present?
  end

  def show
    @tag = Tag.find_by!(name: params[:name])
    @posts = @tag.posts.accepted.includes(%i[user tags])
    @posts = Posts::ListPostsService.call(@posts, params, current_user)

    @users = User.joins(posts: :tags)
                 .where(tags: { id: @tag.id }, posts: { status: :accepted })
                 .group('users.id')
                 .order('count(posts.id) DESC')
                 .limit(16)
                 .with_attached_avatar

    @pagy, @posts = pagy(@posts)
  end
end
