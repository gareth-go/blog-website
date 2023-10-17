class Settings::PasswordController < ApplicationController
  before_action :set_user

  def edit
    authorize [:settings, @user]
  end

  def update
    authorize [:settings, @user]

    unless @user.valid_password?(params[:user][:old_password])
      @old_password_error = 'Password is not correct!'
      render 'edit'
      return
    end

    if @user.update(user_params)
      bypass_sign_in(@user)
      flash[:notice] = 'Your password has been change'
      redirect_to edit_settings_password_path(@user.username)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.required(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find_by!(username: params[:username])
  end
end
