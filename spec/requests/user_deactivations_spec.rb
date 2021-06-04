require 'rails_helper'

RSpec.describe UserDeactivationsController, type: :request do
  let!(:user) { create(:user, :active) }
  before { login_as(user) }

  describe "GET /new" do
    context 'ユーザーのサービスがあるとき' do
      it "returns http success" do
        create(:product, users: [user])
        get "/user_deactivation/new"
        expect(response).to have_http_status(:success)
      end
    end

    context 'ユーザーのサービスがないとき' do
      it "returns http success" do
        get "/user_deactivation/new"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE /create" do
    subject { delete '/user_deactivation' }

    it 'ユーザーを退会させること' do
      expect { subject }.to change { user.reload.status }.to('deactivated').from('general')
    end

    it 'プロダクトが削除されないこと' do
      create(:product, users: [user])
      expect { subject }.not_to change(Product, :count)
    end

    it 'ログアウトすること' do
      expect(logged_in?).to eq true
      subject
      expect(logged_in?).to eq false
    end

    it "トップページに遷移すること" do
      subject
      expect(response).to redirect_to(root_url)
      expect(flash[:notice]).to eq '退会処理が完了しました。ありがとうございました。'
    end
  end
end
