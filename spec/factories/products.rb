# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  released_on :date             not null
#  sourse_url  :string(255)
#  title       :string(255)      not null
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :product do
    sequence(:title, "プロダクト_1")
    description { "MyText" }
    url { Faker::Internet.url }
    sourse_url { Faker::Internet.url }
    released_on { Time.zone.today }
  end
end
