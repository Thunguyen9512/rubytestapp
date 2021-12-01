class AuthenticationController < ApplicationController

    class AuthenticationError < StandardError; end
    # rescue_from AuthenticationError, with: :handle_unauthenticated
    def login
        user = User.find_by(user_name: params[:user_name])
        # raise AuthenticationError unless user.authenticate(params[:password]) #khong nen sai
        if(!user.authenticate(params[:password]))
            return render json: {status: 'FAIL', message: 'Password incorrect'}, status: :unprocessable_entity
        end

        token = AuthenticationTokenService.call(user.id, user.role)

        return render json: {status: 'SUCCESS', token: token}, status: :ok
    end
    # def handle_unauthenticated
    #     head :unauthorized
    # end
end