module Posts
  class PostsSortService < ApplicationService
    def initialize(posts, params)
      @posts = posts
      @params = params
    end

    def call
      sort_by_comments if @params[:sort] == 'comments'
      sort_by_reactions if @params[:sort] == 'reactions'
      sort_by_create_at

      @posts
    end

    private

    def sort_by_create_at
      @posts = @posts.order(created_at: :desc)
    end

    def sort_by_comments
      @posts = @posts.order(comments_count: :desc)
    end

    def sort_by_reactions
      @posts = @posts.order(reactions_count: :desc)
    end
  end
end
