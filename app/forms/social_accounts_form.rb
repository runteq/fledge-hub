class SocialAccountsForm
  include ActiveModel::Model

  attr_accessor :social_accounts_attributes, :user

  validate :social_accounts_validity

  def save
    return false if invalid?

    social_accounts.each do |social_account|
      social_account.destroy! unless social_account.save
    end
    true
  end

  private

  def social_accounts_validity
    error_messages =
      validate_target_accounts.select(&:invalid?).flat_map(&:errors).flat_map(&:full_messages)
    error_messages.each do |error_message|
      errors.add(:base, error_message) unless errors.full_messages.include?(error_message)
    end
  end

  def social_accounts
    @social_accounts ||= social_accounts_attributes.map do |attributes|
      social_account = SocialAccount.find_or_initialize_by(
        user_id: user.id,
        social_service_id: attributes[:social_service_id],
      )
      social_account.identifier = attributes[:identifier]
      social_account
    end
  end

  def validate_target_accounts
    social_accounts.select do |social_account|
      social_account.social_service.base_url.blank? && social_account.identifier?
    end
  end
end
