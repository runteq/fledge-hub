require 'rails_helper'

RSpec.describe UserDeactivationsController, type: :request do
  let!(:user) { create(:user) }
  before { login_as(user) }

  describe "GET /new" do
    it "returns http success" do
      get "/user_deactivation/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /create" do
    subject { delete '/user_deactivation' }

    specify do
      expect { subject }.to change { user.reload.status }.to('deactivated').from('general')
    end

    it "redirects to the users list" do
      subject
      expect(response).to redirect_to(users_url)
    end
  end
end
