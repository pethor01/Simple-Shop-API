
module Api
  module V1
    class RegionsController < Api::ApplicationController
      before_action :check_user_role, only: %i[index create show update destroy]
      before_action :find_region, only: %i[show update destroy]

      def index
        @regions = Region.all
        render json: {regions: @regions}, status: :ok
      end

      def create
        @region = Region.new(region_params)
        if @region.save
          render json: {region: @region, message: 'Region Successfully Created'}, status: :ok 
        end  
        rescue => error
          render json: {errors:  error.message}, status: 400
      end

      def show
        render json: {region:  @region}, status: :ok if @region
        rescue => error
          render json: {errors:  error.message}, status: 400
      end 

      def update
        @region.update(region_params)
        render json: {region: @region, message: 'Region Successfully Updated'}, status: :ok
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      def destroy
        @region.destroy if @region
        render json: {message: 'Region deleted'}, status: :ok
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      private

      def find_region
        @region = Region.find(params[:id])
        rescue => error
          render json: {errors:  error.message}, status: 404
      end
      
      def check_user_role
        render json: {error: 'You dont have access to this'}, status: :unauthorized if @valid && @user.role != 'admin'
      end
      
      def region_params
        params.require(:region).permit(:title, :country, :currency, :tax)  
      end
      
    end
  end
end