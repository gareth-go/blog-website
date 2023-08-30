class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
    @posts = @user.posts.accepted.includes(:tags)
    @comments = @user.comments
  end
end
