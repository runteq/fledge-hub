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
  describe '#url' do
    subject { social_account.url }

    context 'base_urlがあるとき' do
      let!(:social_account) do
        build(
          :social_account,
          identifier: 'account_name',
          social_service_id: social_service.id,
        )
      end
      let!(:social_service) { SocialService.find_by(base_url: 'https://twitter.com/') }
      it { is_expected.to eq 'https://twitter.com/account_name' }
    end

    context 'base_urlがないとき' do
      let!(:social_account) do
        build(
          :social_account,
          identifier: 'https://example.com',
          social_service_id: social_service.id,
        )
      end
      let!(:social_service) { SocialService.find_by(base_url: '') }
      it { is_expected.to eq 'https://example.com' }
    end
  end
end
