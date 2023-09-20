# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :count_unviewed_notifications, if: :user_signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action!'
    redirect_back(fallback_location: root_path)
  end

  def record_not_found
    render 'shared/page_not_found'
  end

  def count_unviewed_notifications
    @unviewed_notifications_count = Notification.where(user: current_user).unviewed.count
  end
end
