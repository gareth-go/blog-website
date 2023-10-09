class SendMailJob
  include Sidekiq::Job

  def perform(id)
    post = Post.find(id)

    PostMailer.with(post: post).post_browsed_email.deliver_now
  end
end
