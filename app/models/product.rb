class Product < ApplicationRecord
  has_many :user_products, dependent: :destroy
  has_many :users, through: :user_products

  def permitted_edit?(user)
    !!user&.in?(users)
  end
end
