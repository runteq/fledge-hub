# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  released_on         :date             not null
#  source_url          :text(65535)      not null
#  summary             :text(65535)      not null
#  title               :string(255)      not null
#  url                 :text(65535)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  product_category_id :integer          not null
#  product_type_id     :integer          not null
#
class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :user_products, dependent: :destroy
  has_many :users, through: :user_products
  has_many :images, lambda {
    order(created_at: :desc)
  }, dependent: :destroy, class_name: 'ProductImage', inverse_of: :product
  has_many :media, dependent: :destroy, class_name: 'ProductMedium', inverse_of: :product
  has_many :product_technologies, dependent: :destroy
  has_many :technologies, through: :product_technologies
  belongs_to_active_hash :product_type
  belongs_to_active_hash :product_category

  validates :title, presence: true, length: { maximum: 100 }
  validates :url, url: { allow_blank: true, schemes: %w[https http] }, length: { maximum: 500 }
  validates :source_url, url: { allow_blank: true, schemes: %w[https http] },
                         length: { maximum: 500 }
  validates :released_on, presence: true
  validates :summary, length: { maximum: 500 }
  validates :product_type_id, presence: true
  validates :product_category_id, presence: true

  def permitted_edit?(user)
    !!user&.in?(users)
  end

  def top_image
    @top_image ||= images.first || DummyImage.new
  end

  def user
    @user ||= users.take
  end
end
