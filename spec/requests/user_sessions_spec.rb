require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  describe "DELETE /logout" do
    let(:user) { create(:user) }
    before { login_as(user) }
    subject { delete '/logout' }

    it "redirect root_path" do
      subject
      expect(response).to redirect_to '/'
    end

    it 'success logged out' do
      expect(logged_in?).to eq true
      subject
      expect(logged_in?).to eq false
    end
  end
end
