class PostsController < ApplicationController
  before_action :set_drafting_post, only: %i[new save]
  before_action :set_post, only: %i[show edit update accept reject destroy publish]

  before_action :authenticate_user!, except: %i[show]

  def show
    authorize @post

    @reaction = current_user&.reactions&.find_by(post: @post)
    @reactions = @post.reactions

    @new_comment = Comment.new
    @comments = @post.comments
                     .where(parent_comment: nil)
                     .order(created_at: :desc)
                     .includes({ user: { avatar_attachment: :blob } }, :parent_comment)

    @book_mark = BookMark.find_by(user: current_user, post: @post)
  end

  def readinglist
    @posts = current_user.saved_posts
                         .includes({ user: { avatar_attachment: :blob } }, :tags)
                         .order('book_marks.id DESC')
    @posts = @posts.where('title LIKE ?', "%#{params[:search_bookmark]}%") if params[:search_bookmark].present?
  end

  def edit
    authorize @post
  end

  def save
    values = post_params_tag_ids_to_tags

    @post.cover_image.purge if params.dig(:post, :remove_cover_image) == '1' && !values.key?(:cover_image)

    @post.update(values)
  end

  def publish
    values = post_params_tag_ids_to_tags

    @post.cover_image.purge if params.dig(:post, :remove_cover_image) == '1' && !values.key?(:cover_image)
    @post.status = current_user.admin? ? :accepted : :pending

    if @post.update(values)
      Notifications::NotifyToFollowerService.call(@post) if @post.accepted?
      redirect_to @post
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    authorize @post

    values = post_params_tag_ids_to_tags

    @post.cover_image.purge if params.dig(:post, :remove_cover_image) == '1' && !values.key?(:cover_image)

    if @post.update(values)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def accept
    authorize @post

    if @post.update(status: :accepted)
      create_notification
      send_mail
    end

    redirect_to dashboard_posts_path(status: :accepted)
  end

  def reject
    authorize @post

    if @post.update(status: :rejected)
      create_notification
      send_mail
    end

    redirect_to dashboard_posts_path(status: :rejected)
  end

  def destroy
    authorize @post

    @post.destroy

    respond_to do |format|
      if request.referer.include?(post_path(@post))
        format.html { redirect_to root_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
        format.html { redirect_to :back }
      end
    end
  end

  private

  def set_drafting_post
    @post = Post.find_or_create_by(user: current_user, status: :drafting)
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
    Notifications::NotifyToFollowerService.call(@post) if @post.accepted?
  end

  def send_mail
    PostMailer.with(post: @post).post_browsed_email.deliver_now
  end
end
