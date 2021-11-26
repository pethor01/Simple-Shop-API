module Api
  module V1
    class ProductsController < Api::ApplicationController
      before_action :check_user_role, only: %i[create update]
      before_action :find_product, only: %i[show update destroy]
       
      def index
        # scope in Product Model
        @products = Product.get_region_products(params[:region_id])
        render json: {products: @products}, status: :ok
      end
      
      def create
        @product = Product.new(product_params)
        if @product.save
          render json: {product: @product, message: 'Product Successfully Created'}, status: :ok 
        end
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      def show
        render json: {product:  @product}, status: :ok if @product
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      def update
        @product.update(product_params)
        render json: {product: @product, message: 'Product Successfully Updated'}, status: :ok
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      private

      def find_product
        @product = Product.find(params[:id])
        rescue => error
          render json: {errors:  error.message}, status: 404
      end
      
      def product_params
        params.require(:product).permit(:title, :image_url, :region_id, :description, :sku, :stock, :price)  
      end

      def check_user_role
        render json: {error: 'You dont have access to this'}, status: :unauthorized if @valid && @user.role != 'admin'
      end
    end
  end
end