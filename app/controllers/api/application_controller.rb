require 'json_web_token'
module Api
  class ApplicationController < ActionController::API
    before_action :authenticate_request
  
    private

    def authenticate_request
      @valid =  false
      @headers = request.headers
      find_user unless decoded_auth_token.nil?
     end

     def find_user
       @user = User.find(decoded_auth_token['user_id'])
       @valid = true if @user
     end
   
     def decoded_auth_token
      JsonWebToken.decode(http_auth_header)
    end
  
    def http_auth_header
      if @headers['Authorization'].present?
        return @headers['Authorization'].split(' ').last 
      else
        render json: {error: 'Unauthorized'}, status: :unauthorized
      end
    end
  end
end
