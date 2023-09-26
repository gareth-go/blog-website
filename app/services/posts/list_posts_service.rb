module Posts
  class ListPostsService < ApplicationService
    def initialize(posts, params, user = nil)
      @posts = posts
      @params = params
      @user = user
    end

    def call
      search if @params[:search].present?
      filter_by_status if Post.statuses.include?(@params[:status])
      filter_by_following if @params[:filter] == 'following'
      sort

      @posts
    end

    private

    def search
      @posts = @posts.where('title LIKE ? OR content LIKE ?',
                            "%#{@params[:search]}%",
                            "%#{@params[:search]}%")
    end

    def filter_by_status
      @posts = @posts.where(status: @params[:status])
    end

    def filter_by_following
      @posts = @posts.where(user: @user&.following_users)
    end

    def sort
      case @params[:sort]
      when 'comments'
        @posts = @posts.order(comments_count: :desc)
      when 'reactions'
        @posts = @posts.order(reactions_count: :desc)
      end

      @posts = @posts.order(created_at: :desc)
    end
  end
end
