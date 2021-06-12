require 'rails_helper'

RSpec.describe OauthsController, type: :request do
  describe "GET /oauth" do
    it "returns http success" do
      get "/oauth/github"
      expected_url = 'https://github.com/login/oauth/authorize?client_id=b00ec15db81aacf99a28&display&redirect_uri=http%3A%2F%2F127.0.0.1%3A3000%2Foauth%2Fcallback%3Fprovider%3Dgithub&response_type=code&scope=user%3Aemail&state'
      expect(response).to redirect_to(expected_url)
    end
  end

  describe "GET oauth/callback?provider=github" do
    context 'ログインできたとき' do
      before do
        # login_from('github')をモックにして、仮想的にlogin_asを実行する
        allow_any_instance_of(OauthsController).to receive(:login_from).with('github') { login_as(create(:user, :active)) }
      end

      it "root_pathにリダイレクトする" do
        get "/oauth/callback?provider=github"
        expect(response).to redirect_to(root_path)
      end
    end

    # context 'ログインできなかったとき（まだユーザー登録していないとき）' do
    #   before do
    #     # login_from('github')をモックにする
    #     allow_any_instance_of(OauthsController).to receive(:login_from).with('github').and_return(false)
    #     allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({})
    #     OauthsController.instance_variable_set('@user_hash', {})
    #   end

    #   it 'ユーザー登録ページにリダイレクトする' do
    #     get "/oauth/callback?provider=github"
    #     expect(response).to redirect_to(new_registration_path)
    #   end
    # end
  end
end
