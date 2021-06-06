# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  display_name     :string(255)      not null
#  email            :string(255)      not null
#  salt             :string(255)
#  screen_name      :string(255)      not null
#  status           :integer          default("general"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email        (email) UNIQUE
#  index_users_on_screen_name  (screen_name) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.active' do
    subject { User.active }

    it '退会済みユーザーを含まないこと' do
      active_user = create(:user, status: :general)
      deactived_user = create(:user, :deactivated)

      is_expected.to include(active_user)
      is_expected.not_to include(deactived_user)
    end
  end

  describe '#deactivate!' do
    let!(:user) { create(:user, id: 1, status: :general) }
    let!(:authentication) { create(:authentication, user: user, provider: 'github') }
    subject { user.deactivate! }

    it 'Userのデータが規定の値になること' do
      expect { subject }.to change { user.reload.display_name }.to('退会済みユーザー')
                        .and change { user.reload.screen_name }.to('removed_account_1')
                        .and change { user.reload.email }.to('removed_account_1@example.com')
                        .and change { user.reload.status }.to('deactivated').from('general')
    end

    it 'Authenticationのproviderがdeactivatedになること' do
      expect { subject }.to change {
        authentication.reload.provider
      }.to('github/deactivated').from('github')
    end
  end
end
