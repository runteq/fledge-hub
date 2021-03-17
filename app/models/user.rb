# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  display_name     :string(255)      not null
#  screen_name      :string(255)      not null
#  email            :string(255)      not null
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :display_name, presence: true
  validates :screen_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
