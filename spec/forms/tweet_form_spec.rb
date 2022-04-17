RSpec.describe TweetForm do
  describe '#save!' do
    subject { form.save! }
    let!(:form) { TweetForm.new(**attributes) }

    context 'バリデーションエラー' do
      let!(:attributes) do
        {
          text: '*' * 141, # バリデーションエラー
          url: '', # バリデーションエラー
        }
      end

      it 'エラーメッセージを持つ' do
        expect { subject }.to raise_error ActiveModel::ValidationError
        expect(form.errors.messages).to eq({
          text: ['は117文字以内で入力してください'],
          url: ['を入力してください', 'は不正なURLです'],
        })
      end
    end

    context '正常系' do
      let!(:attributes) do
        {
          text: 'テキスト',
          url: 'https://example.com',
        }
      end

      context '本番環境' do
        before do
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
        end
        xit 'ツイートする' do
          client_double = instance_double(TwitterClient)
          allow(TwitterClient).to receive(:client).and_return(client_double)
          expect(client_double).to receive(:update).with('テキスト')
          subject
        end
      end
      context '開発環境' do
        before do
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
        end
        it 'ツイートしない' do
          expect(TwitterClient).to_not receive(:client)
          subject
        end
        it 'loggerに出力する' do
          logger_double = instance_double('Rails.logger')
          expect(logger_double).to receive(:info).with("Post to twitter.\nテキスト")
          expect(Rails).to receive(:logger).and_return(logger_double)
          subject
        end
      end
    end
  end
end
