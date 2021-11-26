require "rails_helper"
require 'json_web_token'
RSpec.describe "Orders", type: :request do
  let(:valid_user) { create(:user) }
  let(:region) { create(:region) }
  let(:product) { create(:product, region: region) }
  let(:product_two) { create(:product, 
    region: region,
      title: 'Jordan  IV',
      image_url: "https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369",
      description: 'Nike shoes jordan 4',
      sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
      stock: 10 ,
      price:  2500
    ) 
  }

  let(:product_three) { create(:product, 
    region: region,
      title: 'Jordan  V',
      image_url: "https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369",
      description: 'Nike shoes jordan 5',
      sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
      stock: 10 ,
      price:  3000
    ) 
  }
  let(:token) {JsonWebToken.encode(user_id: valid_user.id)  }
  let(:order_params) do
    {
      "order": {
        "shipping_address": Faker::Address.full_address,
       "order_dtls": [
         ["product_id": product.id, "total_order": 3],
         ["product_id": product_two.id, "total_order": 4]
       ]
      }
    }
  end

  let(:order_params_two) do
    {
      "order": {
        "shipping_address": Faker::Address.full_address,
       "order_dtls": [
         ["product_id": product.id, "total_order": 21],
         ["product_id": product_two.id, "total_order": 21]
       ]
      }
    }
  end
 
  let(:update_params) do
    {
      "order": {
        "shipping_address": Faker::Address.full_address,
       "order_dtls": [
         ["product_id": product.id, "total_order": 3],
         ["product_id": product_two.id, "total_order": 4],
         ["product_id": product_three.id, "total_order": 5],
       ]
      }
    }
  end

  it "Create an order of product" do
    headers = { "Authorization" => "Bearer #{token}"}
    post api_v1_orders_path,  headers: headers, params: order_params
    res = JSON.parse!(response.body)
    find_order = Order.find(res['order']['id'])

    order_count = pluralize(find_order.order_dtls.length, 'Order')
    expect(res['message']).to eq("#{order_count} Successfully Created")
    expect(response).to have_http_status(:ok)
  end

  it "Should not create an order if total is greater than available stock number of product" do
    headers = { "Authorization" => "Bearer #{token}"}
    post api_v1_orders_path,  headers: headers, params: order_params_two
  
    res = JSON.parse!(response.body)
   
    expect(res['errors']).to eq('Your total order is greater than the products stocks')
    expect(response).to have_http_status(400)
  end

  it "show the order" do
    headers = { "Authorization" => "Bearer #{token}"}
    post api_v1_orders_path,  headers: headers, params: order_params
    res = JSON.parse!(response.body)
    find_order = Order.find(res['order']['id'])

    get api_v1_order_path(id: find_order.id), headers: headers
    show_res = JSON.parse!(response.body)
  
    expect(show_res['order']['order_total']).to eq(find_order.order_total)
    expect(response).to have_http_status(:ok)
  end

  it "update the order" do
    headers = { "Authorization" => "Bearer #{token}"}
    post api_v1_orders_path,  headers: headers, params: order_params
    res = JSON.parse!(response.body)
    find_order = Order.find(res['order']['id'])
    
    put "/api/v1/orders/#{find_order.id}", headers: headers,  params: update_params
    update_res = JSON.parse!(response.body)
    
    updated_order = Order.find(update_res['order']['id'])
  
    expect(update_res['order']['order_total']).to eq(updated_order.order_total)
    expect(response).to have_http_status(:ok)
  end

  it "delete the order" do
    headers = { "Authorization" => "Bearer #{token}"}
    post api_v1_orders_path,  headers: headers, params: order_params
    res = JSON.parse!(response.body)
    find_order = Order.find(res['order']['id'])
    
    delete "/api/v1/orders/#{find_order.id}", headers: headers
    delete_res = JSON.parse!(response.body)

    expect(delete_res['message']).to eq('Order deleted')
    expect(response).to have_http_status(:ok)
  end
  

end