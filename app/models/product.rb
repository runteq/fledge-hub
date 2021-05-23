# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  released_on :date             not null
#  source_url  :text(65535)      not null
#  summary     :text(65535)      not null
#  title       :string(255)      not null
#  url         :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  has_many :user_products, dependent: :destroy
  has_many :users, through: :user_products
  has_many :images, dependent: :destroy
  has_many :media, dependent: :destroy
  has_many :product_technologies, dependent: :destroy
  has_many :technologies, through: :product_technologies

  validates :title, presence: true
  validates :url, url: { allow_blank: true, schemes: %w[https http] }
  validates :source_url, url: { allow_blank: true, schemes: %w[https http] }
  validates :released_on, presence: true

  def permitted_edit?(user)
    !!user&.in?(users)
  end

  def top_image
    @top_image ||= images.first || OpenStruct.new(title: title, product_image: 'https://dummyimage.com/720x400')
  end
end
