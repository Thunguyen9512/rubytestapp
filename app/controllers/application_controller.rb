class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    # include Response
    include ExceptionHandler
    include ActionController::Serialization

    before_action :authenticate!
    before_action :authorize_request
    attr_reader :current_user
    
    def authenticate!
        @current_user = AuthorizeApiRequest.new(request.headers).perform!
    end
end
