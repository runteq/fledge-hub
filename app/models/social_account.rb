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
end
