# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  released_on :date             not null
#  source_url  :string(255)
#  title       :string(255)      not null
#  url         :string(255)
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
    @top_image ||= images.first || OpenStruct.new(title: title, url: 'https://dummyimage.com/720x400')
  end
end
