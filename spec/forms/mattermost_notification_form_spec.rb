RSpec.describe MattermostNotificationForm do
  describe '#save!' do
    subject { form.save! }
    let!(:form) { MattermostNotificationForm.new(**attributes) }

    context 'バリデーションエラー' do
      let!(:attributes) do
        {
          username: '', # バリデーションエラー
          channel: '', # バリデーションエラー
          text: '', # バリデーションエラー
        }
      end

      it 'エラーメッセージを持つ' do
        expect { subject }.to raise_error ActiveModel::ValidationError
        expect(form.errors.messages).to eq({ username: ['を入力してください'], channel: ['を入力してください'], text: ['を入力してください'] })
      end
    end

    context '正常系' do
      let!(:attributes) do
        {
          username: '通知アカウント名',
          channel: 'チャンネル',
          text: 'テキスト',
        }
      end

      context '本番環境' do
        before do
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
        end
        it 'Mattermostに通知する' do
          expect(MattermostClient).to receive(:post).with(
            { username: '通知アカウント名', channel: 'チャンネル', text: 'テキスト' }
          )
          subject
        end
      end
      context '開発環境' do
        before do
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
        end
        it 'Mattermostに通知しない' do
          expect(MattermostClient).to_not receive(:post).with(
            { username: '通知アカウント名', channel: 'チャンネル', text: 'テキスト' }
          )
          subject
        end
        it 'loggerに出力する' do
          logger_double = instance_double('Rails.logger')
          expect(logger_double).to receive(:info).with(
            "Message to Mattermost.\n{:username=>\"通知アカウント名\", :channel=>\"チャンネル\", :text=>\"テキスト\"}"
          )
          expect(Rails).to receive(:logger).and_return(logger_double)
          subject
        end
      end
    end
  end
end
