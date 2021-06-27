require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      create(:user, :active)
      get users_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    subject { get "/users/#{user.screen_name}" }

    context 'ユーザーが退会していないとき' do
      let!(:user) { create(:user, :active) }

      it 'renders a successful response' do
        subject
        expect(response).to be_successful
      end
    end

    context '退会済みユーザーのとき' do
      let!(:user) { create(:user, :deactivated) }

      it '404エラーになる' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
