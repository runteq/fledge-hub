FactoryBot.define do
  factory :product do
    sequence(:title, "プロダクト_1")
    description { "MyText" }
    url { Faker::Internet.url }
    sourse_url { Faker::Internet.url }
    released_on { Time.zone.today }
  end
end
