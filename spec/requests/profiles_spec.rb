require 'rails_helper'

RSpec.describe "/profile", type: :request do
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
        expect(response).to redirect_to(user_url(user))
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
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:user) { create(:user) }
    subject { delete profile_url(user) }

    specify do
      expect { subject }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      subject
      expect(response).to redirect_to(users_url)
    end
  end
end
