# == Schema Information
#
# Table name: social_services
#
#  id         :bigint           not null, primary key
#  base_url   :string(255)      not null
#  icon       :text(65535)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SocialService < ApplicationRecord
  has_many :social_accounts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :icon, presence: true, length: { maximum: 10_000 }
  validates :base_url, url: { allow_blank: true, schemes: %w[https http] }
end
