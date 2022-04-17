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
      context 'current_userがないとき' do
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
        it do
          double = instance_double(MattermostNotificationForm)
          allow(double).to receive(:save!)
          expect(MattermostNotificationForm).to receive(:new).with(
            channel: 'fledge-hub',
            username: 'お問い合わせ',
            text: "| name | name_test |\n | -- | -- |\n | email | test@example.com |\n | about | about_test |\n | user_agent | user_agent_test |\n\ndescription_test",
          ).and_return(double)
          subject
        end
        it 'レコードを作成する' do
          expect { subject }.to change(Inquiry, :count).by(1)
        end
      end

      context 'current_userがあるとき' do
        let!(:user) { create(:user) }
        let!(:attributes) do
          {
            name: 'name_test',
            email: 'test@example.com',
            about: 'about_test',
            description: 'description_test',
            user_agent: 'user_agent_test',
            current_user: user,
          }
        end

        it do
          double = instance_double(MattermostNotificationForm)
          allow(double).to receive(:save!)
          expect(MattermostNotificationForm).to receive(:new).with(
            channel: 'fledge-hub',
            username: 'お問い合わせ',
            text: "| name | name_test（user_id: #{user.id}） |\n | -- | -- |\n | email | test@example.com |\n | about | about_test |\n | user_agent | user_agent_test |\n\ndescription_test",
          ).and_return(double)
          subject
        end
      end
    end
  end
end
