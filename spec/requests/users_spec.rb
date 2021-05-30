require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      create(:user)
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }

    it "renders a successful response" do
      get user_url(user.screen_name)
      expect(response).to be_successful
    end
  end
end
