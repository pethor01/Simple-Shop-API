require "rails_helper"
require 'json_web_token'
RSpec.describe "Regions", type: :request do
  let(:valid_user) { create(:user) }
  let(:admin_user) { create(:user, role: 1) }
  let(:region) { create(:region) }
  let(:region_params) do
    {
      "region": {
        "title": 'Southern Thailand',
        "country": 'Thailand',
        "currency": 'THB',
        "tax": 0.1,
      }
    }
  end

  it "response nil if Authorization Headers is blank" do
    get api_v1_regions_path
    res = JSON.parse!(response.body)
    expect(res['error']).to eq('Unauthorized')
    expect(response).to have_http_status(:unauthorized)
  end

  it "Should not display the list of regions if the role is not admin " do
    token = JsonWebToken.encode(user_id: valid_user.id)
    valid_user
    headers = { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" }
    get api_v1_regions_path,  headers: headers
    res = JSON.parse!(response.body)
    expect(res['error']).to eq('You dont have access to this')
    expect(response).to have_http_status(:unauthorized)
  end

  it "Display all the regions if the role is admin" do
    region
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" }
    get api_v1_regions_path,  headers: headers
    list_region = Region.all
    res = JSON.parse!(response.body)
 
    expect(res['regions'].length).to eq(list_region.length)
    expect(response).to have_http_status(:ok)
  end
  
  it "Show the region if the role is admin" do
    region
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" }
    get api_v1_region_path(id: region.id),  headers: headers
    list_region = Region.all
    res = JSON.parse!(response.body)
 
    expect(res['region']['title']).to eq(region.title)
    expect(response).to have_http_status(:ok)
  end

  it "Should not create a region if the role is not admin " do
    token = JsonWebToken.encode(user_id: valid_user.id)
    headers = { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" }
    post api_v1_regions_path,  headers: headers
    res = JSON.parse!(response.body)
    expect(res['error']).to eq('You dont have access to this')
    expect(response).to have_http_status(:unauthorized)
  end

  it "Should create a region if the role is admin " do
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = {"Authorization" => "Bearer #{token}"}
    post api_v1_regions_path,  headers: headers, params: region_params
    res = JSON.parse!(response.body)
  
    expect(res['region']['country']).to eq('Thailand')
  end

  it "Should update a region if the role is admin " do
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = {"Authorization" => "Bearer #{token}"}
    put api_v1_region_path(id: region.id),  headers: headers, params: {region: {title: 'Region 1', tax: "0.13"}}
    res = JSON.parse!(response.body)

    expect(res['message']).to eq('Region Successfully Updated')
    expect(res['region']['title']).to eq('Region 1')
  end

  it "destroy a region if the role is admin " do
    token = JsonWebToken.encode(user_id: admin_user.id)
    headers = {"Authorization" => "Bearer #{token}"}

    delete "/api/v1/regions/#{region.id}", headers: headers
    res = JSON.parse!(response.body)
    
    expect(res['message']).to eq('Region deleted')
    expect(response).to have_http_status(:ok)
  end
end