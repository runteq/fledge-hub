# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  released_on :date             not null
#  sourse_url  :string(255)
#  title       :string(255)      not null
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  has_many :user_products, dependent: :destroy
  has_many :users, through: :user_products

  validates :title, presence: true
  validates :url, url: { allow_blank: true }
  validates :sourse_url, url: { allow_blank: true }
  validates :released_on, presence: true

  def permitted_edit?(user)
    !!user&.in?(users)
  end
end
