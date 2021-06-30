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
