require 'webmock/rspec'

WebMock.allow_net_connect! # inquiry以外ではwebmockは使わない

MATTERMOST_WEBHOOK_URL = Rails.application.credentials.mattermost[:webhook_url]

RSpec.describe InquiryForm do
  describe "#post_to_mattermost" do
    before do
      WebMock.disable!(except: [:net_http])
      WebMock.stub_request(:post, MATTERMOST_WEBHOOK_URL).to_return(
        body: {"text": "test_inquiry_form"}.to_json,
        status: 200,
        headers: { 'Content-Type' =>  'application/json' }
      )
    end

    subject { InquiryForm.new }
    it "will_be_successful" do
      response = subject.send(:post_to_mattermost)
      expect(response.body).to eq({"text": "test_inquiry_form"}.to_json)
    end
  end

  # saveメソッドのテストかく
  # describe "#save" do
  # end
end
