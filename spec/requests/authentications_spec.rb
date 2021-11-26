require "rails_helper"

RSpec.describe "Authentications", type: :request do
  let(:valid_user) { create(:user) }

  it "Check if the user is authenticated" do
    post api_v1_authentications_path, params: {
      email: valid_user.email, password: valid_user.password
    }
    expect(response).to have_http_status(:ok)
  end

  it "Check if the user is authenticated" do
    post api_v1_authentications_path, params: {
      email: valid_user.email, password: '1fasf'
    }
    res = JSON.parse!(response.body)
        
    expect(res['error']).to eq('Invalid username / password')
    expect(response).to have_http_status(:unauthorized)
  end
end