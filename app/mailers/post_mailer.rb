class PostMailer < ApplicationMailer
  def post_browsed_email
    @post = params[:post]
    mail(to: @post.user.email, subject: "Your post has been #{@post.status}")
  end
end
