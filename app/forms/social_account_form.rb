class SocialAccountForm
  include ActiveModel::Model

  attr_accessor :social_accounts_attributes, :user

  # ここから下は、参考にしたふぉーむおぶじぇくとのままなので、

  # validates :name, :about, :description, :user_agent, presence: true

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  def save
    return false if invalid?

    post_to_mattermost
    save_inquiry!
    true
  end

  private

  def save_inquiry!
    Inquiry.new(name: name, email: email, about: about, description: description,
                user_agent: user_agent).save!
  end
end
