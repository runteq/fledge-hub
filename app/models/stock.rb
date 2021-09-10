# == Schema Information
#
# Table name: stocks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  fk_rails_f4b3894c0d                     (user_id)
#  index_stocks_on_product_id_and_user_id  (product_id,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :product_id, uniqueness: { scope: :user_id }
end
