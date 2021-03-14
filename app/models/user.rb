class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :display_name, presence: true
  validates :screen_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
