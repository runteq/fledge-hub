class InquiryForm
  include ActiveModel::Model

  attr_accessor :name, :email, :about, :description, :user_agent

  validates :name, :about, :description, :user_agent, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  def save
    return false if invalid?

    MattermostNotifier.call(
      channel: 'fledge-hub',
      username: 'お問い合わせ',
      text: text,
    )
    save_inquiry!
    true
  end

  private

  def text
    "| name | #{name} |\n | -- | -- |\n | email | #{email} |\n | about | #{about}|\n | user_agent | #{user_agent}|\n#{description}"
  end

  def save_inquiry!
    Inquiry.new(name: name, email: email, about: about, description: description,
                user_agent: user_agent).save!
  end
end
