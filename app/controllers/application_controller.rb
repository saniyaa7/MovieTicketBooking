# frozen_string_literal: true

class ApplicationController < ActionController::API
  # protect_from_forgery
  # include ActionController::Helpers
  # include ActionController::Cookies
  # include ActionController::RequestForgeryProtection

  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, if_not: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception.message }, status: :unauthorized
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name age phone_no role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email name age phone_no role_id])
  end
end
