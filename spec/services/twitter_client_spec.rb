require 'rails_helper'

RSpec.describe TwitterClient do
  describe '.posted_notification_text' do
    subject { TwitterClient.posted_notification_text(product) }
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
      let!(:twitter_account) { create(:social_account, identifier: 'fledge_hub', user: user, social_service_id: SocialService.twitter.id) }
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
end
