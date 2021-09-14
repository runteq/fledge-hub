# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  released_on         :date             not null
#  source_url          :text(65535)      not null
#  summary             :text(65535)      not null
#  title               :string(255)      not null
#  url                 :text(65535)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  product_category_id :integer          not null
#  product_type_id     :integer          not null
#
FactoryBot.define do
  factory :product do
    sequence(:title, 'プロダクト_1')
    summary { 'MyText' }
    url { '' }
    source_url { Faker::Internet.url }
    released_on { Time.zone.today }
    product_type_id { ProductType.pluck(:id).sample }
    product_category_id { ProductCategory.pluck(:id).sample }

    trait :with_user do
      after(:build) do |product|
        create(:user, products: [product])
      end
    end

    trait :yesterday do
      released_on { Time.zone.yesterday }
    end

    trait :today do
      released_on { Time.zone.today }
    end

    trait :tomorrow do
      released_on { Time.zone.tomorrow }
    end
  end
end
