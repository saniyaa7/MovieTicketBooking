# frozen_string_literal: true

class ApplicationController < ActionController::API
  # protect_from_forgery
  # include ActionController::Helpers
  # include ActionController::Cookies
  # include ActionController::RequestForgeryProtection

  # def current_user
  #   @current_user ||= User.find(payload['sub'])
  # end
  before_action :authorized
  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception.message }, status: :unauthorized
  end

  # check_authorization
  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:secret_key_base])
    # This method takes a payload and returns a JWT token. The payload is a hash that contains the user's id. The JWT token is generated using the JWT.encode method, which takes the payload and the secret key base as arguments.
  end

  def decoded_token
    header = request.headers['Authorization']
    return unless header

    token = header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.credentials[:secret_key_base])
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def authorized
    return unless current_user.nil?

    render json: { message: 'Please log in' }, status: :unauthorized
  end
end
