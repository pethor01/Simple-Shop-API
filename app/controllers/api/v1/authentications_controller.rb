require 'json_web_token'

module Api
  module V1
    class AuthenticationsController < ActionController::API

      def create
        user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
          valid_user(user)
        else
          render json: {error: 'Invalid username / password'}, status: :unauthorized
        end
      end

      private
        def valid_user(user)
          auth_token = JsonWebToken.encode({user_id: user.id})
          render json: {auth_token: auth_token}, status: :ok
        end
        
    end
  end
end