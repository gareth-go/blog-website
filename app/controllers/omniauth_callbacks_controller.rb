class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    generic_callback('google')
  end

  private

  def generic_callback(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url, locals: { resource: @user }
    end
  end
end
