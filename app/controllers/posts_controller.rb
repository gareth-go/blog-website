class PostsController < ApplicationController
  before_action :set_new_post, only: %i[create]
  before_action :set_post, only: %i[show]

  def show; end

  def new
    @post = Post.new
  end

  def create
    # remove blank tag value
    # convert from tag_id to tag object
    values = post_params
    values['tags'].shift
    values['tags'].map! { |tag| Tag.find(tag) }

    if @post.update(values)
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  private

  def set_new_post
    # set status of new post is accepted if user is admin
    @post = Post.new(user_id: current_user.id)
    @post.status = :accepted if current_user.admin?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.required(:post).permit(:title, :cover_image, :content, tags: [])
  end
end
