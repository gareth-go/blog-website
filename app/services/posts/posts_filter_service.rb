module Posts
  class PostsFilterService < ApplicationService
    def initialize(posts, params)
      @posts = posts
      @params = params
    end

    def call
      search if @params[:search].present?
      filter_by_status if Post.statuses.include?(@params[:status])

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
  end
end
