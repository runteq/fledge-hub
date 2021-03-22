# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  title       :string(255)      not null
#  url         :string(255)      not null
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
class Image < ApplicationRecord
  belongs_to :product
end
