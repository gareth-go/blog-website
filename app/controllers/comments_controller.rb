class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, except: %i[create]
  before_action :set_parent_comment, :set_new_comment, only: %i[create]

  before_action :authenticate_user!

  def create
    if @new_comment.update(comment_params)
      set_comments
    else
      redirect_to @post
    end
  end

  def update
    if @comment.update(comment_params)
      set_comments
    else
      redirect_to @post
    end
  end

  def destroy
    @comment.destroy
    @post.reload

    set_comments
  end

  private

  def comment_params
    params.required(:comment).permit(:content)
  end

  def set_new_comment
    @new_comment = Comment.new(user: current_user, post: @post)
    @new_comment.parent_comment = @parent_comment if params[:comment_id].present?
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_parent_comment
    @parent_comment = Comment.find(params[:comment_id]) if params[:comment_id].present?
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comments
    @comments = Comment.where(post: @post, parent_comment: nil).order(created_at: :desc).includes(%i[user parent_comment])
  end
end
