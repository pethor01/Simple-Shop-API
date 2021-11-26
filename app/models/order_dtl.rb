class OrderDtl < ApplicationRecord
  belongs_to :order
  belongs_to :product
  after_save :update_product_stock

  def new_order_dtl(order_id, params)
    product = Product.find(params[:product_id])
    valid_order = check_stock(params, product)
    if valid_order
      save_order(order_id, params)
    else
      return false
    end
  end

  #updating order_total will add first the initial order_total to product stock
  def update_order(order, params)
    valid_order = check_stock(params, order.product)
    if valid_order
      order.product.add_stock(order.order_total)
      params[:total_price] = @total_price
      update_order_dtl(order, params)
    end
  end

  private

  def save_order(order_id, params)
    order = OrderDtl.new(order_id: order_id, 
                        product_id: params[:product_id], 
                        total_order: params[:total_order],
                        total_price: @total_price,
                      )
    order.save!
    
    rescue => error
      return  [error:  error.message, valid: false]
  end
  
  def update_product_stock
    self.product.update_stock(total_order)
  end

  def check_stock(params, product)
    order_total = params[:total_order].to_i
    if product && product.stock >= order_total
      @total_price = product.total_price(order_total).to_f
    else
      return nil
    end
  end
end
