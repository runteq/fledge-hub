class MattermostNotifier
  SERVER_URL = 'https://chat.runteq.jp'.freeze
  WEBHOOK_URL = Rails.application.credentials.mattermost[:webhook_url]

  class << self
    def call(text:, username: 'Fledge Hub通知', channel: 'fledge-hub')
      if Rails.env.production?
        post_to_mattermost(channel, username, text)
      else
        Rails.logger.info 'Message to Mattermost.'
      end
    end

    private

    def post_to_mattermost(channel, username, text)
      post_payload = { username: username, channel: channel, text: text }

      post_by_faraday(SERVER_URL, post_payload)
    end

    def post_by_faraday(post_url, payload)
      conn = Faraday::Connection.new(url: post_url) do |faraday|
        faraday.request :url_encoded
        faraday.response :raise_error
        faraday.headers['Content-Type'] = 'application/json'
        faraday.adapter Faraday.default_adapter
      end

      conn.post do |req|
        req.url WEBHOOK_URL
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end
    end
  end
end
