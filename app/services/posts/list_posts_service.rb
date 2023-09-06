module Posts
  class ListPostsService < ApplicationService
    def initialize(posts, params)
      @posts = posts
      @params = params
    end

    def call
      search if @params[:search].present?
      filter_by_status if Post.statuses.include?(@params[:status])
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
