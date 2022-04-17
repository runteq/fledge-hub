# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  display_name     :string(255)      not null
#  email            :string(255)      not null
#  salt             :string(255)
#  screen_name      :string(255)      not null
#  status           :integer          default("general"), not null
#  study_started_on :date             not null
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

  # dependent: :destroyだけど、Userを物理削除することはない
  has_many :user_products, dependent: :destroy
  has_many :products, through: :user_products
  has_many :stocks, dependent: :destroy
  has_many :stock_products, through: :stocks, source: :product
  has_many :authentications, dependent: :destroy
  has_many :social_accounts, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :display_name, presence: true, length: { maximum: 30 }
  validates :avatar, attached: true,
                     content_type: %r{\Aimage/.*\z},
                     size: { less_than: 1.megabytes }
  validates :screen_name, presence: true,
                          uniqueness: true,
                          length: { maximum: 30 },
                          format: { with: /\A[\w-]+\z/, message: 'には半角英数字と_-のみ使えます。' }
  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 100 },
                    'valid_email_2/email': { strict_mx: true }
  validates :study_started_on, presence: true, date: { before: proc { Time.zone.today } }

  enum status: { general: 0, deactivated: 10 }

  scope :active, -> { where.not(status: :deactivated) }

  def registration(avatar_url, user_hash)
    transaction do
      grab_avatar_image(avatar_url)
      if save
        authentications.find_or_create_by!(
          provider: 'github',
          uid: user_hash['id'],
        )
        social_accounts.create!(
          identifier: user_hash['login'],
          social_service_id: SocialService.find_by(name: 'GitHub').id,
        )
        true
      else
        false
      end
    end
  end

  def deactivate!
    transaction do
      update!(
        display_name: '退会済みユーザー',
        screen_name: "removed_account_#{id}",
        email: "removed_account_#{id}@example.com",
        status: :deactivated,
      )
      avatar.purge_later
      authentications.each do |authentication|
        authentication.update!(
          provider: "#{authentication.provider}/deactivated",
        )
      end
      social_accounts.destroy_all
    end
  end

  def grab_avatar_image(url)
    avatar_file = url.open
    avatar.attach(io: avatar_file, filename: "user_avatar_#{id}.jpg")
  end

  def active?
    !deactivated?
  end

  def twitter_name
    social_accounts.find_by(social_service_id: SocialService.twitter.id)&.identifier
  end
end
