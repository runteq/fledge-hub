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
FactoryBot.define do
  factory :user_product do
    user
    product
  end
end
