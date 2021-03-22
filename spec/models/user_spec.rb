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
  describe '#deactivate!' do
    let(:user) { create(:user, id: 1, status: :general) }
    subject { user.deactivate! }
    it { expect { subject }.to change { user.reload.display_name }.to('退会済みユーザー') }
    it { expect { subject }.to change { user.reload.screen_name }.to('removed_account_1') }
    it { expect { subject }.to change { user.reload.email }.to('removed_account_1@example.com') }
    it { expect { subject }.to change { user.reload.status }.to('deactivated').from('general') }
  end
end
