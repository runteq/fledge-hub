require 'rails_helper'

RSpec.describe Settings::SocialAccountsController, type: :request do
  let!(:user) { create(:user) }
  before { login_as(user) }

  describe "GET /index" do
    subject { get '/settings/social_accounts' }

    it "render a successful response" do
      create(:social_account, user: user)
      subject
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /upsert_all" do
    let!(:social_service_id) { SocialService.pluck(:id).sample }
    subject { post '/settings/social_accounts', params: { user: attributes } }

    context '既にsocial_accountがある場合' do
      let!(:social_account) { create(:social_account, identifier: 'prev_identifier', social_service_id: social_service_id, user: user) }
      let!(:attributes) do
        {
          social_accounts_attributes: [
            {
              social_service_id: social_service_id,
              identifier: 'new_identifier',
            },
          ]
        }
      end

      it "updates the social_account" do
        expect { subject }.to change { social_account.reload.identifier }.to('new_identifier').from('prev_identifier')
      end

      it "redirects to the social_accounts" do
        subject
        expect(response).to redirect_to(settings_social_accounts_url)
      end
    end

    context 'social_accountが存在しない場合' do
      let!(:attributes) do
        {
          social_accounts_attributes: [
            {
              social_service_id: social_service_id,
              identifier: 'identifier',
            },
          ]
        }
      end

      it 'creates social_account' do
        expect { subject }.to change(SocialAccount, :count).by(1)
      end

      it "redirects to the social_accounts" do
        subject
        expect(response).to redirect_to(settings_social_accounts_url)
      end
    end
  end
end
