# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  description :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_images_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :image do
    description { "MyText" }
    product_image { Rack::Test::UploadedFile.new('spec/fixtures/files/images/720x400.png', 'image/png') }
    product
  end
end
