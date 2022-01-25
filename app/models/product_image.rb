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
class ProductImage < ApplicationRecord
  NO_IMAGE_URL = 'https://placehold.jp/70/d6d6d6/7d7d7d/800x450.png?text=No%20Image'.freeze

  belongs_to :product
  has_one_attached :product_image

  validates :product_image, attached: true,
                            content_type: %r{\Aimage/.*\z},
                            size: { less_than: 10.megabytes }
end
