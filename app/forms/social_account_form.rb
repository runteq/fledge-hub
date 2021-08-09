class SocialAccountForm
  include ActiveModel::Model

  attr_accessor :social_accounts_attributes, :user

  validate :social_accounts_validity

  def save
    return false if invalid?

    social_accounts.each(&:create_or_update_or_destroy)
    true
  end

  private

  def social_accounts_validity
    social_accounts.select(&:invalid?).flat_map(&:errors).flat_map(&:full_messages).each do |full_message|
      # ごりおし↓
      next if full_message == 'Identifierを入力してください'

      errors.add(:social_accounts_attributes, "の#{full_message}")
    end
  end

  def social_accounts
    @social_accounts ||= social_accounts_attributes.map do |social_account|
      social_account = SocialAccount.find_or_initialize_by(
        user_id: user.id,
        social_service_id: social_account[:social_service_id],
      )
      social_account.assign_attributes(
        identifier: social_account[:identifier],
      )
      social_account
    end
  end
end
