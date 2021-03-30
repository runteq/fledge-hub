# == Schema Information
#
# Table name: technologies
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  slug       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_technologies_on_name  (name) UNIQUE
#  index_technologies_on_slug  (slug) UNIQUE
#
class Technology < ApplicationRecord
  has_many :product_technologies, dependent: :destroy
  has_many :products, through: :product_technologies

  validates :name, uniqueness: true
  validates :slug, uniqueness: true
end
