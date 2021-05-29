# == Schema Information
#
# Table name: media
#
#  id          :bigint           not null, primary key
#  description :text(65535)      not null
#  title       :string(255)      not null
#  url         :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_media_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Medium < ApplicationRecord
  belongs_to :product

  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true, url: { allow_blank: true, schemes: %w[https http] }, length: { maximum: 500 }
  validates :description, length: { maximum: 500 }
end
