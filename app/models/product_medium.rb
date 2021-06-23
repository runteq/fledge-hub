# == Schema Information
#
# Table name: product_media
#
#  id         :bigint           not null, primary key
#  title      :string(255)      not null
#  url        :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_media_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class ProductMedium < ApplicationRecord
  belongs_to :product

  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true, url: { allow_blank: true, schemes: %w[https http] },
                  length: { maximum: 500 }
end
