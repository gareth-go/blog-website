module CommentsHelper
  def menu_if_owner_or_admin(user, post, comment)
    if user == post.user || policy(comment).destroy?
      if comment.parent_comment.present?
        render partial: 'comments/reply_menu', locals: { parent_comment: comment.parent_comment, reply: comment }
        return
      end

      render 'comments/comment_menu', comment: comment
    end
  end
end
