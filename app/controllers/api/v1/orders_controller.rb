include ActionView::Helpers::TextHelper
module Api
  module V1
    class OrdersController < Api::ApplicationController
      before_action :find_order, only: %i[show update destroy]

      def create
        order = Order.new.new_order(order_params, @user.id)
        @order = Order.find(order)
        if @order.order_dtls.length > 0
          create_order(@order)
          render json: {order: @order, message: "#{@order_count} Successfully Created"}, status: :ok
        else
          @order.destroy
          render json: {errors:  'Your total order is greater than the products stocks'}, status: 400
        end
      end
      
      def show
        render json: {order:  @order, order_details: @order.order_dtls}, status: :ok if @order
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      def update
        if @order
          update_order
        end
        rescue => error
          render json: {errors:  error.message}, status: 400
      end

      def destroy
        delete_order if @order
        render json: {message: 'Order deleted'}, status: :ok
        rescue => error
          render json: {errors:  error.message}, status: 400
      end
      
      private
  
      def create_order(order)
        order.update_total_order_price(order.order_dtls)
        @order_count = pluralize(order.order_dtls.length, 'Order')
        PaymentJob.set(wait: 1.minute).perform_later(order)
      end

      def update_order
        delete_order
        order = Order.new.new_order(order_params, @user.id)
        @update_order = Order.find(order)
        updated_order
      end

      def updated_order
        if @update_order.order_dtls.length > 0
          create_order(@update_order)
          render json: {order: @update_order, message: 'Order Successfully Updated'}, status: :ok 
        else
          @update_order.destroy
          render json: {errors:  'Your total order is greater than the products stocks'}, status: 400
        end
      end
      
      def delete_order
        @order.order_dtls.each do |order_dtl|
          order_dtl.product.add_stock(order_dtl.total_order)
        end
        @order.destroy
      end
      
      def find_order
        @order = Order.find(params[:id])
        rescue => error
          render json: {errors:  error.message}, status: 404
      end
      
      def order_params
        params.require(:order).permit(:user_id, :shipping_address, :order_total, :total_price, order_dtls: [:product_id, :total_order]) 
      end
      
    end
  end
end