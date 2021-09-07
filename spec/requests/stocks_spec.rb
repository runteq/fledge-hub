require 'rails_helper'

RSpec.describe "Stocks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/stocks/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/stocks/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/stocks/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
