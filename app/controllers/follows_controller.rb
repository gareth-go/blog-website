class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :create

  def create
    Follow.create(user: @user, follower: current_user)
    redirect_to user_path(@user.username)
  end

  def destroy
    @user = Follow.destroy(params[:id]).user
    redirect_to user_path(@user.username)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
