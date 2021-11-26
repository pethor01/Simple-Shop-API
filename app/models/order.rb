class Order < ApplicationRecord
  has_many :order_dtls,  dependent: :destroy
  has_many :payments,  dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :order_dtls
  
  def new_order(params, user_id)
    if params[:order_dtls].length >= 1
      create_order = Order.new(shipping_address: params[:shipping_address], user_id: user_id)
      create_order_dtls(create_order, params)
    else
      error = 'Please select a product'
      return [error: error, valid: false]
    end
  end

  def update_total_order_price(order_dtls)
    total_order = order_dtls.length
    total_price = order_dtls.sum(:total_price)
    self.update(order_total: total_order, total_price: total_price)
  end

  private

  def create_order_dtls(order, params)
    if order.save!
      params[:order_dtls].each do |order_dtl|
       OrderDtl.new.new_order_dtl(order.id, order_dtl)
      end
      return order.id
    end
  end
  
  def update_order_dtl(order, params)
    order.update(params)
    return [order: order, valid: true]
    rescue => error
      return  [error:  error.message, valid: false]
  end
  
  def save_order(params)
    order = Order.new(params)
    order.save!
    return [order: order, valid: true]
    rescue => error
      return  [error:  error.message, valid: false]
  end
  
  def check_stock(params, product)
    order_total = params[:order_total].to_i
    if product && product.stock >= order_total
      @total_price = product.total_price(order_total).to_f
    else
      return nil
    end
  end
  
end
