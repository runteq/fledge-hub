# == Schema Information
#
# Table name: product_technologies
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#  technology_id :bigint           not null
#
# Indexes
#
#  index_product_technologies_on_product_id     (product_id)
#  index_product_technologies_on_technology_id  (technology_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (technology_id => technologies.id)
#
require 'rails_helper'

RSpec.describe ProductTechnology, type: :model do
end
