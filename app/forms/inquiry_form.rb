class InquiryForm
  include ActiveModel::Model

  attr_accessor :name, :contact, :title, :description, :user_agent

  validates :name, :title, :description, presence: true

  def save
    return false if invalid?

    post_to_mattermost
    save_inquiry!
    true
  end

  private

  def post_to_mattermost
    mattermost_url = 'https://chat.runteq.jp'

    conn = Faraday::Connection.new(url: mattermost_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :raise_error
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end

    conn.post do |req|
      req.url ENV['MATTERMOST_WEBHOOK_URL']
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        text: "name: #{@name}\n contact: #{@contact}\n title: #{@title}\n description: #{@description}\n user_agent: #{@user_agent}"
      }.to_json
    end
  end

  def save_inquiry!
    Inquiry.new(name: @name, contact: @contact, title: @title, description: @description,
                user_agent: @user_agent).save!
  end
end
