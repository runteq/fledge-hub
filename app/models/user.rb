class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :display_name, presence: true
  validates :screen_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
