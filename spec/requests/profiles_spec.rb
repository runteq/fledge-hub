require 'rails_helper'

RSpec.describe ProfilesController, type: :request do
  before { login_as(user) }

  describe "GET /edit" do
    let(:user) { create(:user) }
    subject { get profile_url }

    it "render a successful response" do
      subject
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }
    subject { get edit_profile_url }

    it "render a successful response" do
      subject
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    let(:user) { create(:user, display_name: '古い表示名') }
    subject { patch profile_url, params: { user: attributes } }

    context "with valid parameters" do
      let(:attributes) do
        {
          display_name: '新しい表示名',
        }
      end

      it "updates the requested user" do
        expect { subject }.to change { user.reload.display_name }.to('新しい表示名').from('古い表示名')
      end

      it "redirects to the user" do
        subject
        expect(response).to redirect_to(user_url(user.screen_name))
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          display_name: '',
        }
      end

      it "does not update the requested user" do
        expect { subject }.not_to change { user.reload.display_name }.from('古い表示名')
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end
end
