FactoryBot.define do
  factory :user do
    sequence(:display_name, "名前_1")
    sequence(:screen_name, "screen_name_1")
    sequence(:email){|n| "test_#{n}@example.com"}
  end
end
