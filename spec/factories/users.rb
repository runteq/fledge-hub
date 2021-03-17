# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  display_name     :string(255)      not null
#  screen_name      :string(255)      not null
#  email            :string(255)      not null
#  crypted_password :string(255)
#  salt             :string(255)
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
    sequence(:email){|n| "test_#{n}@example.com"}
  end
end
