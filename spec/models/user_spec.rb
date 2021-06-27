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
        .and not_include(deactived_user)
    end
  end

  describe '#registration' do
    subject { user.registration(avatar_url, user_hash) }

    context 'バリデーションエラーのとき' do
      let!(:user) { build(:user, screen_name: '') }
      let!(:avatar_url) { Rails.root.join('spec/fixtures/files/images/avatar_test.png') }
      let!(:user_hash) do
        # メソッド内で使う値だけ入れている
        {
          'id' => Random.new_seed,
          'login' => 'github_account_name'
        }
      end

      it { is_expected.to eq false }
      specify do
        expect { subject }.to not_change(User, :count)
          .and not_change(Authentication, :count)
          .and not_change(SocialAccount, :count)
      end
    end

    context '値が適切なとき' do
      let!(:user) { build(:user) }
      let!(:avatar_url) { Rails.root.join('spec/fixtures/files/images/avatar_test.png') }
      let!(:user_hash) do
        # メソッド内で使う値だけ入れている
        {
          'id' => Random.new_seed,
          'login' => 'github_account_name'
        }
      end

      it { is_expected.to eq true }
      specify do
        expect { subject }.to change(User, :count).by(1)
                          .and change(Authentication, :count).by(1)
                          .and change(SocialAccount, :count).by(1)
      end
    end
  end

  describe '#deactivate!' do
    let!(:user) { create(:user, status: :general) }
    let!(:authentication) { create(:authentication, user: user, provider: 'github') }
    let!(:social_account) { create(:social_account, user: user) }
    subject { user.deactivate! }

    it 'Userのデータが規定の値になること' do
      expect { subject }.to change { user.reload.display_name }.to('退会済みユーザー')
                        .and change { user.reload.status }.to('deactivated').from('general')
      expect(user.reload.screen_name).to include 'removed_account_'
      expect(user.reload.email).to include 'removed_account_'
    end

    it 'Authenticationのproviderがdeactivatedになること' do
      expect { subject }.to change {
        authentication.reload.provider
      }.to('github/deactivated').from('github')
    end

    it '紐づくSocialAccountを削除する' do
      expect { subject }.to change(SocialAccount, :count).by(-1)
    end
  end
end
