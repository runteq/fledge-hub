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

  validates :name, uniqueness: true, length: { maximum: 100 }
  validates :slug, uniqueness: true,
                   format: {
                     with: /\A[a-zA-Z0-9_-]+\z/,
                     message: 'の「%<value>s」には使用できない文字が含まれています',
                   },
                   length: { maximum: 100 }
end
