class InquiryForm
  include ActiveModel::Model

  attr_accessor :name, :email, :about, :description, :user_agent, :current_user

  validates :name, :about, :description, :user_agent, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  def save
    return false if invalid?

    form = MattermostNotificationForm.new(
      channel: 'fledge-hub',
      username: 'お問い合わせ',
      text: text,
    )
    form.save!
    save_inquiry!
    true
  end

  private

  def text
    "| name | #{name}#{current_user_text} |\n | -- | -- |\n | email | #{email} |\n | about | #{about} |\n | user_agent | #{user_agent} |\n\n#{description}"
  end

  def current_user_text
    current_user ? "（user_id: #{current_user&.id}）" : ''
  end

  def save_inquiry!
    Inquiry.new(name: name, email: email, about: about, description: description,
                user_agent: user_agent).save!
  end
end
