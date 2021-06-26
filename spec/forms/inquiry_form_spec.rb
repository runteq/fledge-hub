require 'webmock/rspec'

WebMock.allow_net_connect! # inquiry以外ではwebmockは使わない

MATTERMOST_WEBHOOK_URL = Rails.application.credentials.mattermost[:webhook_url]

RSpec.describe InquiryForm do
  before do
    WebMock.disable!(except: [:net_http])
    WebMock.stub_request(:post, MATTERMOST_WEBHOOK_URL).to_return(
      body: {"text": "test_inquiry_form"}.to_json,
      status: 200,
      headers: { 'Content-Type' =>  'application/json' }
    )
  end
  describe "#post_to_mattermost" do
    subject { InquiryForm.new }
    it "will_be_successful" do
      response = subject.send(:post_to_mattermost)
      expect(response.body).to eq({"text": "test_inquiry_form"}.to_json)
    end
  end

  describe '#save' do
    subject { form.send(:save) }
    let!(:form) { InquiryForm.new(**attributes) }

    context 'バリデーションエラー' do
      let!(:attributes) do
        {
          name: '', # バリデーションエラー
          email: 'test@example.com',
          about: 'about_test',
          description: '', # バリデーションエラー
          user_agent: 'user_agent_test'
        }
      end

      it { expect(subject).to be false }
      it 'レコードを作成しない' do
        expect { subject }.not_to change(Inquiry, :count)
      end
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ name: ['を入力してください'], description: ['を入力してください']})
      end
    end

    context '正常系' do
      let!(:attributes) do
        {
          name: 'name_test',
          email: 'test@example.com',
          about: 'about_test',
          description: 'description_test',
          user_agent: 'user_agent_test'
        }
      end

      it { expect(subject).to be true }
      it 'レコードを作成する' do
        expect { subject }.to change(Inquiry, :count).by(1)
      end
    end
  end
end
