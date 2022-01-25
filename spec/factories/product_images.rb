# == Schema Information
#
# Table name: product_images
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_images_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :product_image do
    product_image do
      Rack::Test::UploadedFile.new('spec/fixtures/files/images/720x400.png', 'image/png')
    end
    product
  end
end
