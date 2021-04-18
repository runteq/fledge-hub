# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  released_on :date             not null
#  source_url  :string(255)
#  summary     :text(65535)
#  title       :string(255)      not null
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :product do
    sequence(:title, "プロダクト_1")
    summary { "MyText" }
    url { Faker::Internet.url }
    source_url { Faker::Internet.url }
    released_on { Time.zone.today }
  end
end
