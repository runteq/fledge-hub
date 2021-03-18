# == Schema Information
#
# Table name: user_products
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_products_on_product_id  (product_id)
#  index_user_products_on_user_id     (user_id)
#
require 'rails_helper'

RSpec.describe UserProduct, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
