class SocialAccountForm
  include ActiveModel::Model

  attr_accessor :social_accounts_attributes, :user

  def save 
    social_accounts_attributes.each do |social_account|
      SocialAccount.create_or_update_or_destroy(
        user_id: user.id,
        social_service_id: social_account[:social_service_id],
        identifier: social_account[:identifier],
      )
    end
    true
  end
end
