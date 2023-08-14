class PostsController < ApplicationController
  before_action :set_new_post, only: %i[new create]
  before_action :set_post, only: %i[show]

  def show; end

  def new; end

  def create
    # remove blank tag value
    # convert from tag_id to tag object
    values = post_params
    values['tags'].shift
    values['tags'].map! { |tag| Tag.find(tag) }

    if @post.update(values)
      redirect_to post_path(@post)
    else
      render json: @post.errors.messages
    end
  end

  private

  def set_new_post
    # set status of new post is accepted if user is admin
    @post = Post.new(user_id: current_user.id)
    @post.status = 1 if current_user.admin?
  end

  def set_post
    @post = Post.find(params[:id])
    @post.to_global_id.to_s
    @post.to_signed_global_id.to_s
  end

  def post_params
    params.required(:post).permit!
  end
end
