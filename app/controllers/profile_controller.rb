class ProfileController < ApplicationController
  before_action :set_user

  def show
    @posts = @user.posts.accepted.includes(:tags)
    @comments = @user.comments
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile has been update'
      redirect_to edit_profile_path(@user.username)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.required(:user).permit(:username, :email, :avatar)
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
