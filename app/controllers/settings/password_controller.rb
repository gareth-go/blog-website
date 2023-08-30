class Settings::PasswordController < ApplicationController
  before_action :set_user

  def update
    unless @user.valid_password?(params[:user][:old_password])
      @old_password_error = 'Password is not correct!'
      render 'edit'
      return
    end

    if @user.update(user_params)
      sign_in(@user, bypass: true)
      flash[:notice] = 'Your password has been change'
      redirect_to edit_settings_password_path(@user.username)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.required(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
