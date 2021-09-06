require 'rails_helper'

RSpec.describe SearchesController, type: :request do
  describe 'GET /show' do
    let!(:params) {
      {
        q: {
          title: 'サービス名'
        }
      }
    }
    subject { get search_url(params) }

    it 'renders a successful response' do
      create(:product, title: '検索されない') # usersが存在しないので、描画されるとエラーになる
      create(:product, :with_user, title: 'サービス名')
      subject
      expect(response).to be_successful
    end
  end
end
