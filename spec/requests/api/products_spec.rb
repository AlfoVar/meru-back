# spec/requests/api/products_spec.rb
require 'rails_helper'

RSpec.describe "Api::Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/products"
      expect(response).to have_http_status(:success)
    end

    it "Devuelve una lista de productos" do
      FactoryBot.create_list(:product, 3)
      get "/api/products"
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end