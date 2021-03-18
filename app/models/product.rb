class Product < ApplicationRecord
  has_many :user_products, dependent: :destroy
  has_many :users, through: :user_products

  validates :title, presence: true
  validates :released_on, presence: true

  def permitted_edit?(user)
    !!user&.in?(users)
  end
end
