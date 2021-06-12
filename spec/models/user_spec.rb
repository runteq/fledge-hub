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

  describe '#registration' do
    subject { user.registration(avatar_url, authentication_uid) }

    context 'バリデーションエラーのとき' do
      let!(:user) { build(:user, screen_name: '') }
      let!(:avatar_url) { Rails.root.join('spec/fixtures/files/images/avatar_test.png') }
      let!(:authentication_uid) { Random.new_seed }

      it { is_expected.to eq false }
      specify do
        expect { subject }.not_to change(User, :count)
      end
    end

    context '値が適切なとき' do
      let!(:user) { build(:user) }
      let!(:avatar_url) { Rails.root.join('spec/fixtures/files/images/avatar_test.png') }
      let!(:authentication_uid) { Random.new_seed }

      it { is_expected.to eq true }
      specify do
        expect { subject }.to change(User, :count)
                          .and change(Authentication, :count)
      end
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

  describe '#github_url' do
    let!(:user) { create(:user, screen_name: 'github_screen_name') }
    subject { user.github_url }

    it { is_expected.to eq 'https://github.com/github_screen_name' }
  end
end
