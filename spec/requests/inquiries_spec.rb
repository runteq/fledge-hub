require 'rails_helper'

RSpec.describe "Inquiries", type: :request do
  describe "GET /new" do
    subject { get new_inquiry_url }

    it "returns http success" do
      subject
      expect(response).to be_successful
    end
  end

  # faradayのテストどうやって書くのがいいか考え中
  describe "GET /create" do
    let(:inquiry){ create(:inquiry) }
    subject { post inquiry_url, params: inquiry }

    xit "returns http success" do
      subject
      expect(response).to be_successful
    end
  end
end
