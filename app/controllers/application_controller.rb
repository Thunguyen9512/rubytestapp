class ApplicationController < ActionController::Base
    include ActionController::HttpAuthentication::Token

    include Pundit
    skip_before_action :verify_authenticity_token

    # after_action :verify_authorized, only: :index

    def current_user
        @current_user
    end

    private
    def authenticate_user
        token, _option = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        @current_user = User.find(user_id)
        User.find(user_id)
    rescue ActiveRecord::RecordNotFound
        # render  status: :unauthorized
        head :unauthorized
    end
end