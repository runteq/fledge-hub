FactoryBot.define do
  factory :product do
    sequence(:title, "プロダクト_1")
    description { "MyText" }
    url { "MyString" }
    sourse_url { "MyString" }
    released_on { Time.zone.today }
  end
end
