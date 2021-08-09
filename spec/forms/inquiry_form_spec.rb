require 'webmock/rspec'

RSpec.describe InquiryForm do
  describe '#save' do
    subject { form.save }
    let!(:form) { InquiryForm.new(**attributes) }

    context 'バリデーションエラー' do
      let!(:attributes) do
        {
          name: '', # バリデーションエラー
          email: 'test@example.com',
          about: 'about_test',
          description: '', # バリデーションエラー
          user_agent: 'user_agent_test',
        }
      end

      it { expect(subject).to be false }
      it 'レコードを作成しない' do
        expect { subject }.not_to change(Inquiry, :count)
      end
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ name: ['を入力してください'], description: ['を入力してください'] })
      end
    end

    context '正常系' do
      let!(:attributes) do
        {
          name: 'name_test',
          email: 'test@example.com',
          about: 'about_test',
          description: 'description_test',
          user_agent: 'user_agent_test',
        }
      end

      it { expect(subject).to be true }
      specify do
        expect(MattermostNotifier).to receive(:message).with(
          channel_url: InquiryForm::CHANNEL_URL,
          text: "| name | name_test |\n | -- | -- |\n | email | test@example.com |\n | about | about_test|\n | description | description_test|\n | user_agent | user_agent_test|"
        )
        subject
      end
      it 'レコードを作成する' do
        expect { subject }.to change(Inquiry, :count).by(1)
      end
    end
  end
end
