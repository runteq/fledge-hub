# == Schema Information
#
# Table name: social_accounts
#
#  id                :bigint           not null, primary key
#  identifier        :text(65535)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  social_service_id :integer          not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_social_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe SocialAccount, type: :model do
  describe '.upsert' do
    subject { SocialAccount.upsert(**attribute) }

    context 'identifierが空文字のとき' do
      let!(:user) { create(:user) }
      let!(:social_service_id) { SocialService.pluck(:id).sample }
      let!(:attribute) do
        {
          user_id: user.id,
          social_service_id: social_service_id,
          identifier: '',
        }
      end

      it 'createしない' do
        expect { subject }.to not_change(SocialAccount, :count)
      end
    end

    context 'user_id, social_service_idが一致するレコードが既にあるとき' do
      let!(:social_account) { create(:social_account, identifier: 'prev_identifier') }
      let!(:attribute) do
        {
          user_id: social_account.user_id,
          social_service_id: social_account.social_service_id,
          identifier: 'new_identifier',
        }
      end

      it 'updateする' do
        expect { subject }.to change { social_account.reload.identifier }.to('new_identifier').from('prev_identifier')
      end
    end

    context 'user_id, social_service_idが一致するレコードが存在しないとき' do
      let!(:user) { create(:user) }
      let!(:social_service_id) { SocialService.pluck(:id).sample }
      let!(:attribute) do
        {
          user_id: user.id,
          social_service_id: social_service_id,
          identifier: 'identifier',
        }
      end

      it 'createする' do
        expect { subject }.to change { user.social_accounts.count }.by(1)
      end
    end
  end

  describe '#url' do
    subject { social_account.url }

    context 'base_urlがあるとき' do
      let!(:social_account) { build(:social_account, identifier: 'account_name', social_service_id: social_service.id) }
      let!(:social_service) { SocialService.find_by(base_url: 'https://twitter.com/') }
      it { is_expected.to eq 'https://twitter.com/account_name' }
    end

    context 'base_urlがないとき' do
      let!(:social_account) { build(:social_account, identifier: 'https://example.com', social_service_id: social_service.id) }
      let!(:social_service) { SocialService.find_by(base_url: '') }
      it { is_expected.to eq 'https://example.com' }
    end
  end
end
