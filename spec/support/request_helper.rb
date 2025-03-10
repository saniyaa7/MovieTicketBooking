# frozen_string_literal: true

# # spec/support/request_helper.rb

# module RequestHelper
#   def add_request_headers(user)
#     request.headers['Content-Type'] = 'application/json'
#     request.headers['Authorization'] = user ? "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials[:secret_key_base])}" : ''
#   end
# end

module RequestHelper
  def add_request_headers(user)
    request.headers['Content-Type'] = 'application/json'
    request.headers['Authorization'] =
      user ? "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials[:secret_key_base])}" : ''
  end
end
