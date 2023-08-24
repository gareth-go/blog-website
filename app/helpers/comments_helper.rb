module CommentsHelper
  def menu_if_owner_or_admin(user, post, comment)
    if user == post.user || user == comment.user || user.admin?
      render partial: 'comments/reply_menu', locals: { parent_comment: comment.parent_comment, reply: comment } if comment.parent_comment.present?

      render 'comments/comment_menu', comment: comment
    end
  end
end
