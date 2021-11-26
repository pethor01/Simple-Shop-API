require "rails_helper"
require 'json_web_token'
RSpec.describe "Products", type: :request do
  let(:valid_user) { create(:user) }
  let(:admin_user) { create(:user, role: 1) }
  let(:region) { create(:region) }
  let(:product) { create(:product, region: region) }
  let(:product_params) do
    {
      "product": {
        "region_id": region.id,
        "title": "Jordan  IV",
        "image_url": "https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369",
        "description": 'Nike shoes jordan 4',
        "sku": Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
        "stock": 10 ,
        "price":  1500
      }
    }
  end

  let(:update_product_params) do
    {
      "product": {
        "region_id": region.id,
        "title": "Dior Jordan",
        "image_url": "https://images.stockx.com/images/Air-Jordan-1-Retro-High-Dior-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1607043976",
        "description": 'Jordan 1 Retro High',
        "sku": Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
        "stock": 20 ,
        "price":  25000
      }
    }
  end

  it "Display all the products of specific region" do
    product
    token = JsonWebToken.encode(user_id: valid_user.id)
    headers = { "Authorization" => "Bearer #{token}"}
    get api_v1_products_path(region_id: region.id),  headers: headers
    list_products = Region.all
  
    res = JSON.parse!(response.body)
    expect(res['products'].length).to eq(list_products.length)
    expect(response).to have_http_status(:ok)
  end

  it "show  the product" do
    product
    token = JsonWebToken.encode(user_id: valid_user.id)
    headers = { "Authorization" => "Bearer #{token}"}
    get api_v1_product_path(id: product.id),  headers: headers
    
    res = JSON.parse!(response.body)
    expect(res['product']['title']).to eq(product.title)
    expect(response).to have_http_status(:ok)
  end

  it "Create a product for specific region if the role is admin" do
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = { "Authorization" => "Bearer #{token}"}
    post api_v1_products_path,  headers: headers, params: product_params
  
    res = JSON.parse!(response.body)
    expect(res['product']['title']).to eq('Jordan  IV')
    expect(response).to have_http_status(:ok)
  end

  it "should not create a product for specific region if the role is not admin" do
    token = JsonWebToken.encode(user_id: valid_user.id)
    headers = {"Authorization" => "Bearer #{token}"}
    post api_v1_products_path,  headers: headers, params: product_params
    res = JSON.parse!(response.body)

    expect(res['error']).to eq('You dont have access to this')
    expect(response).to have_http_status(:unauthorized)
  end

  it "update a product for specific region if the role is admin" do
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = { "Authorization" => "Bearer #{token}"}
    put api_v1_product_path(id: product.id),  headers: headers, params: update_product_params
  
    res = JSON.parse!(response.body)
    expect(res['product']['title']).to eq('Dior Jordan')
    expect(res['product']['price']).to eq('25000.0')
    expect(response).to have_http_status(:ok)
  end

  it "should not update a product for specific region if the role is not admin" do
    token = JsonWebToken.encode(user_id: valid_user.id)
    headers = {"Authorization" => "Bearer #{token}"}
    put api_v1_product_path(id: product.id),  headers: headers, params: update_product_params
    res = JSON.parse!(response.body)

    expect(res['error']).to eq('You dont have access to this')
    expect(response).to have_http_status(:unauthorized)
  end
end 