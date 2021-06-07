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
FactoryBot.define do
  factory :user do
    sequence(:display_name, "名前_1")
    sequence(:screen_name, "screen_name_1")
    sequence(:email) { |n| "test_#{n}@example.com" }
    status { User.statuses.keys.sample }

    after(:build) do |user|
      user.avatar.attach(io: File.open('spec/fixtures/files/images/avatar_test.png'), filename: 'avatar_test.png', content_type: 'image/png')
    end

    trait :active do
      status { :general }
    end

    trait :deactivated do
      display_name { '退会済みユーザー' }
      sequence(:screen_name, "removed_account_1")
      sequence(:email) { |n| "removed_account_#{n}@example.com" }
      status { :deactivated }
    end
  end
end
