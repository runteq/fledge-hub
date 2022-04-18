# == Schema Information
#
# Table name: social_accounts
#
#  id                :bigint           not null, primary key
#  identifier        :text(65535)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  social_service_id :integer          not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_social_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class SocialAccount < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to_active_hash :social_service

  validates :identifier, presence: true

  delegate :service_name, :icon, to: :social_service

  class << self
    def sorted(social_accounts)
      social_accounts.sort_by { |social_account| social_account.social_service.position }
    end

    def create_or_update_or_destroy(user_id:, social_service_id:, identifier:)
      social_account = find_or_initialize_by(
        user_id: user_id,
        social_service_id: social_service_id,
      )
      # 更新に失敗 = identifierが空なので、レコードを削除する
      social_account.update(identifier: identifier) || social_account.destroy!
    end
  end

  def url
    "#{social_service.base_url}#{identifier}"
  end
end
