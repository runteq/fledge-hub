RSpec.describe TweetForm do
  describe '.posted_notification_text' do
    subject { TweetForm.posted_notification_text(product) }
    let!(:product) { create(:product, title: 'プロダクト名', summary: '*' * 200) }
    let!(:user) { create(:user, display_name: 'Fledge Hub') }
    let!(:_user_product) { create(:user_product, user: user, product: product) }

    it 'テキストにプロダクト名を含む' do
      expect(subject).to include('プロダクト名')
    end
    it '本文が117字（URLを除く文字数制限）以内になる' do
      expect(subject.length).to be <= 117
    end

    context 'Twitterアカウントが登録されている場合' do
      let!(:twitter_account) do
        create(
          :social_account,
          identifier: 'fledge_hub',
          user: user,
          social_service_id: SocialService.twitter.id,
        )
      end
      it 'Twitterアカウント名を含む' do
        expect(subject).to include('@fledge_hub')
      end
    end

    context 'Twitterアカウントが登録されていない場合' do
      it 'ユーザー名を含む' do
        expect(subject).to include('Fledge Hub')
      end
    end
  end

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
          url: %w[を入力してください は不正なURLです],
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
        it 'ツイートする' do
          client_double = instance_double(External::TwitterClient)
          allow(External::TwitterClient).to receive(:new).and_return(client_double)
          expect(client_double).to receive(:post).with("テキスト\nhttps://example.com")
          subject
        end
      end
      context '開発環境' do
        before do
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
        end
        it 'ツイートしない' do
          expect(External::TwitterClient).to_not receive(:new)
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
