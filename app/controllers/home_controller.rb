class HomeController < ApplicationController
  def index
    @is_sign_in = user_signed_in?
  end
end
