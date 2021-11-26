class Product < ApplicationRecord
  has_many :orders
  belongs_to :region
  
  validates :title, :image_url, :description,  :sku, :stock, :price,  presence: true
  
  scope :get_region_products, ->(region_id){includes(:region).where(region_id: region_id)}
  
  def total_price(order_total)
    total_order_price = price * order_total
    total_order_price + add_tax(total_order_price)
  end

  def add_tax(total_order_price)
    total_order_price * region.tax
  end
  
  def add_stock(order_total)
    quantity = stock + order_total
    self.update(stock: quantity)
  end
  
  def update_stock(order_total)
    quantity = stock - order_total
    self.update(stock: quantity)
  end
  
end
