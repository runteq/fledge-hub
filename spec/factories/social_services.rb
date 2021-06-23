# == Schema Information
#
# Table name: social_services
#
#  id         :bigint           not null, primary key
#  base_url   :string(255)      not null
#  icon       :text(65535)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :social_service do
    name { Faker::Lorem.word }
    icon { Faker::Lorem.word }
    base_url { Faker::Internet.url }
  end
end
