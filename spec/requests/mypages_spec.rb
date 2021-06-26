require 'rails_helper'

RSpec.describe MypagesController, type: :request do
  before { login_as(user) }

  describe "GET /show" do
    let(:user) { create(:user) }
    subject { get '/mypage' }

    it "render a successful response" do
      subject
      expect(response).to have_http_status(:success)
    end
  end
end
