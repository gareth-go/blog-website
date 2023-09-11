class PostsController < ApplicationController
  before_action :set_new_post, only: %i[create]
  before_action :set_post, only: %i[show edit update accept reject destroy]

  before_action :authenticate_user!, except: %i[show]

  after_action :create_notification, only: %i[accept reject]

  def show
    authorize @post

    @reaction = current_user&.reactions&.find_by(post: @post)
    @reactions = @post.reactions

    @new_comment = Comment.new
    @comments = @post.comments
                     .where(parent_comment: nil)
                     .order(created_at: :desc)
                     .includes({ user: { avatar_attachment: :blob } }, :parent_comment)
  end

  def new
    @post = Post.new
  end

  def edit
    authorize @post
  end

  def create
    values = post_params_tag_ids_to_tags

    if @post.update(values)
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def update
    authorize @post

    values = post_params_tag_ids_to_tags

    # set cover_image nil if no image is attached
    @post.cover_image.purge if params.dig(:post, :remove_cover_image) == '1' && !values.key?(:cover_image)

    if @post.update(values)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def accept
    authorize @post

    @post.update(status: :accepted)
    redirect_to dashboard_posts_path(status: :accepted)
  end

  def reject
    authorize @post

    @post.update(status: :rejected)
    redirect_to dashboard_posts_path(status: :rejected)
  end

  def destroy
    authorize @post

    @post.destroy
    redirect_to dashboard_posts_path
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

  def post_params_tag_ids_to_tags
    # remove blank tag value
    # convert from tag_id to tag object
    values = post_params
    values[:tags]&.shift
    values[:tags]&.map! { |tag_id| Tag.find(tag_id) }

    values
  end

  def create_notification
    Notifications::CreateNotificationService.call(@post.user, @post, 'post')
  end
end
