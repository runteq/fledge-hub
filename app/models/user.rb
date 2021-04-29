# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  display_name     :string(255)      default(""), not null
#  email            :string(255)      not null
#  salt             :string(255)
#  screen_name      :string(255)      not null
#  status           :integer          default("general"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email        (email) UNIQUE
#  index_users_on_screen_name  (screen_name) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :user_products, dependent: :destroy
  has_many :products, through: :user_products
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :display_name, presence: true
  validates :screen_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  enum status: { general: 0, deactivated: 10 }

  def deactivate!
    update!(
      display_name: "退会済みユーザー",
      screen_name: "removed_account_#{id}",
      email: "removed_account_#{id}@example.com",
      status: :deactivated
    )
  end
end
