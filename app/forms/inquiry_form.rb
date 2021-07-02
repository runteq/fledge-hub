class InquiryForm
  include ActiveModel::Model

  attr_accessor :name, :email, :about, :description, :user_agent

  validates :name, :about, :description, :user_agent, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  def save
    return false if invalid?

    post_to_mattermost
    save_inquiry!
    true
  end

  private

  def post_to_mattermost
    mattermost_url = 'https://chat.runteq.jp'
    mattermost_channel_url = Rails.application.credentials.mattermost[:webhook_url]
    post_payload = {
      text: "| name | #{name} |\n | -- | -- |\n | email | #{email} |\n | about | #{about}|\n | description | #{description}|\n | user_agent | #{user_agent}|",
    }

    post_by_faraday(mattermost_url, mattermost_channel_url, post_payload)
  end

  def post_by_faraday(post_url, channel_url, payload)
    conn = Faraday::Connection.new(url: post_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :raise_error
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end

    conn.post do |req|
      req.url channel_url
      req.headers['Content-Type'] = 'application/json'
      req.body = payload.to_json
    end
  end

  def save_inquiry!
    Inquiry.new(name: name, email: email, about: about, description: description,
                user_agent: user_agent).save!
  end
end
