require 'rails_helper'

RSpec.describe "Inquiries", type: :request do
  describe "GET /new" do
    subject { get new_inquiry_url }

    it "returns http success" do
      subject
      expect(response).to be_successful
    end
  end
end
