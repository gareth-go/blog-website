class CommentsController < ApplicationController
  before_action :set_comment, except: %i[create]
  before_action :set_parent_comment, :set_post
  before_action :set_new_comment, only: %i[create]

  before_action :authenticate_user!

  def create
    redirect_to @post unless @new_comment.update(comment_params)
  end

  def update
    redirect_to @post unless @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
    @parent_comment&.reload
    @post.reload
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
    @post = if params[:post_id].present?
              Post.find(params[:post_id])
            else
              @comment&.post || @parent_comment.post
            end
  end

  def set_parent_comment
    @parent_comment = Comment.find(params[:comment_id]) if params[:comment_id].present?
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
