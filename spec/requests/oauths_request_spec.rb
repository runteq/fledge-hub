require 'rails_helper'

RSpec.describe "Oauths", type: :request do
  describe "GET /oauth" do
    it "returns http success" do
      get "/oauths/oauth"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /callback" do
    it "returns http success" do
      get "/oauths/callback"
      expect(response).to have_http_status(:success)
    end
  end
end
