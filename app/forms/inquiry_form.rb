class InquiryForm
  include ActiveModel::Model

  attr_accessor :name, :email, :about, :description, :user_agent

  validates :name, :about, :description, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

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
    payload = {
      text: "name: #{name}\n email: #{email}\n about: #{about}\n description: #{description}\n user_agent: #{user_agent}"
    }

    conn = Faraday::Connection.new(url: mattermost_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :raise_error
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end

    conn.post do |req|
      req.url mattermost_channel_url
      req.headers['Content-Type'] = 'application/json'
      req.body = payload.to_json
    end
  end

  def save_inquiry!
    Inquiry.new(name: name, email: email, about: about, description: description,
                user_agent: user_agent).save!
  end
end
