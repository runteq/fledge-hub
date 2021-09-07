require 'rails_helper'

RSpec.describe StocksController, type: :request do
  let(:user) { create(:user) }
  before { login_as(user) }

  describe "GET /create" do
    let!(:product) { create(:product) }
    subject { post "/products/#{product.id}/stock" }

    it "returns http success" do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'Stockを作成する' do
      expect { subject }.to change(Stock, :count).by(1)
    end
  end

  describe "DELETE /destroy" do
    let!(:product) { create(:product) }
    subject { delete "/products/#{product.id}/stock" }
    before do
      # ストックしておく
      create(:stock, user: user, product: product)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'Stockを削除する' do
      expect { subject }.to change(Stock, :count).by(-1)
    end
  end
end
