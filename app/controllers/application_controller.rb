class ApplicationController < ActionController::API
    # protect_from_forgery
    before_action :authorized


    def encode_token(payload)
      JWT.encode(payload, Rails.application.credentials[:secret_key_base])
      # This method takes a payload and returns a JWT token. The payload is a hash that contains the user's id. The JWT token is generated using the JWT.encode method, which takes the payload and the secret key base as arguments.
    end
  
    def decoded_token
      header = request.headers['Authorization']
      if header
        token = header.split(" ")[1]
        begin
          JWT.decode(token,  Rails.application.credentials[:secret_key_base])
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
  
    def current_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
      end
    end
  
    def authorized
      unless !!current_user
      render json: { message: 'Please log in' }, status: :unauthorized
      end
    end
end
