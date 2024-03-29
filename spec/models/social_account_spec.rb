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
  describe '.sorted' do
    it 'SocialServiceのposition順で並び替える' do
      service2 = SocialService.create(position: 2)
      account2 = create(:social_account, id: 1, social_service_id: service2.id)
      service1 = SocialService.create(position: 1)
      account1 = create(:social_account, id: 2, social_service_id: service1.id)
      service3 = SocialService.create(position: 3)
      account3 = create(:social_account, id: 3, social_service_id: service3.id)

      expect(SocialAccount.sorted(SocialAccount.order(:id))).to eq(
        [account1, account2, account3],
      )
    end
  end

  describe '.create_or_update_or_destroy' do
    subject { SocialAccount.create_or_update_or_destroy(**attribute) }

    context 'user_id, social_service_idが一致するレコードが既にあるとき' do
      context 'identifierが空文字のとき' do
        let!(:social_account) { create(:social_account) }
        let!(:attribute) do
          {
            user_id: social_account.user_id,
            social_service_id: social_account.social_service_id,
            identifier: '',
          }
        end

        it 'destroyする' do
          expect { subject }.to change(SocialAccount, :count).by(-1)
        end
      end

      context 'identifierがあるとき' do
        let!(:social_account) { create(:social_account, identifier: 'prev_identifier') }
        let!(:attribute) do
          {
            user_id: social_account.user_id,
            social_service_id: social_account.social_service_id,
            identifier: 'new_identifier',
          }
        end

        it 'updateする' do
          expect { subject }.to change {
            social_account.reload.identifier
          }.to('new_identifier').from('prev_identifier')
        end
      end
    end

    context 'user_id, social_service_idが一致するレコードが存在しないとき' do
      let!(:user) { create(:user) }
      let!(:social_service_id) { SocialService.pluck(:id).sample }

      context 'identifierが空文字のとき' do
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

      context 'identifierがあるとき' do
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
  end

  describe '#url' do
    subject { social_account.url }

    context 'base_urlがあるとき' do
      let!(:social_account) do
        build(:social_account, identifier: 'account_name', social_service_id: social_service.id)
      end
      let!(:social_service) { SocialService.create(base_url: 'https://example.com/') }
      it { is_expected.to eq 'https://example.com/account_name' }
    end

    context 'base_urlがないとき' do
      let!(:social_account) do
        build(
          :social_account,
          identifier: 'https://example.com',
          social_service_id: social_service.id,
        )
      end
      let!(:social_service) { SocialService.create(base_url: '') }
      it { is_expected.to eq 'https://example.com' }
    end
  end
end
