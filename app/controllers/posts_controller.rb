class PostsController < ApplicationController
  before_action :set_new_post, only: %i[create]
  before_action :set_post, only: %i[show edit update accept reject destroy add_reaction]
  before_action :set_reaction, only: %i[change_reaction remove_reaction show]

  before_action :require_admin, only: %i[accept reject]
  before_action :require_owner, only: %i[edit create]
  before_action :require_owner_or_admin, only: %i[destroy]

  before_action :authenticate_user!, except: %i[show]

  def index
    @posts = if current_user.admin?
               Post.all.order(created_at: :desc).includes(%i[user tags])
             else
               current_user.posts.order(created_at: :desc).includes(%i[tags])
             end

    @posts = @posts.where(status: Post.statuses[params[:status]]) if params[:status] &&
                                                                     Post.statuses.include?(params[:status])
  end

  def show
    @reactions = Reaction.where(post: @post)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    values = post_params_tag_ids_to_tags

    if @post.update(values)
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def update
    values = post_params_tag_ids_to_tags

    # set cover_image nil if no image is attached
    @post.cover_image.purge if params.dig(:post, :remove_cover_image) == '1' && !values.key?(:cover_image)
    # values.delete(:remove_cover_image)

    if @post.update(values)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def accept
    @post.update(status: :accepted)

    redirect_to @post
  end

  def reject
    @post.update(status: :rejected)

    redirect_to @post
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  def add_reaction
    if Reaction.reaction_types.include?(params[:reaction_type]) &&
       @post.reactions.create(user: current_user, reaction_type: params[:reaction_type])
      @reactions = Reaction.where(post: @post)
      @reaction = set_reaction
    else
      render 'show'
    end
  end

  def change_reaction
    if Reaction.reaction_types.include?(params[:reaction_type]) &&
       @reaction.update(reaction_type: params[:reaction_type])
      @reactions = Reaction.where(post_id: params[:id])
      @reaction = set_reaction
    else
      render 'show'
    end
  end

  def remove_reaction
    @reaction.delete
    @reaction = set_reaction

    @reactions = Reaction.where(post_id: params[:id])
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

  def set_reaction
    @reaction = Reaction.find_by(user: current_user, post_id: params[:id])
  end

  def post_params
    params.required(:post).permit(:title, :cover_image, :content, tags: [])
  end

  def post_params_tag_ids_to_tags
    # remove blank tag value
    # convert from tag_id to tag object
    values = post_params
    values[:tags].shift
    values[:tags].map! { |tag_id| Tag.find(tag_id) }

    values
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def require_owner
    redirect_to root_path unless @post.user == current_user
  end

  def require_owner_or_admin
    redirect_to root_path unless current_user.admin? || @post.user == current_user
  end
end
