class ApplicationController < ActionController::Base
    require 'json_web_token'

        protect_from_forgery unless: -> { request.format.json? }
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        helper_method :is_owner, :current_user
        protected
# Validates the token and user and sets the @current_user scope
def authenticate_request!
  if !payload || !JsonWebToken.valid_payload(payload.first)
    return invalid_authentication
  end

  load_current_user!
  invalid_authentication unless @current_user
end

# Returns 401 response. To handle malformed / invalid requests.
def invalid_authentication
redirect_to login_path
end

private
# Deconstructs the Authorization header and decodes the JWT token.
def payload
  auth_token = cookies[:auth_token]
  return unless auth_token

  JsonWebToken.decode(auth_token)
rescue
  nil
end

# Sets the @current_user with the user_id from payload
def load_current_user!
  @current_user = User.find_by(id: payload[0]['user_id'])
end

def record_not_found(exception)
  render json: { error: exception.message }, status: :not_found
end


def is_owner(item)
  @current_user && item.created_by == @current_user.id
end
def current_user
  @current_user
end


    end
