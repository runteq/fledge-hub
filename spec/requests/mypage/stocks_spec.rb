require 'rails_helper'

RSpec.describe Mypage::StocksController, type: :request do
  let(:user) { create(:user) }
  before { login_as(user) }

  describe 'GET /mypage/stocks' do
    subject { get '/mypage/stocks' }

    it 'render a successful response' do
      product = create(:product, :with_user)
      create(:stock, user: user, product: product)
      subject
      expect(response).to have_http_status(:success)
    end
  end
end
