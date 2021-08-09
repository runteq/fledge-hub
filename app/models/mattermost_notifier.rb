class MattermostNotifier
  SERVER_URL = 'https://chat.runteq.jp'

  class << self
    def call(channel_url:, text:)
      if Rails.env.production?
        post_to_mattermost(channel_url, text)
      else
        Rails.logger.info 'Message to Mattermost.'
      end
    end

    private

    def post_to_mattermost(channel_url, text)
      post_payload = { text: text }

      post_by_faraday(SERVER_URL, channel_url, post_payload)
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
  end
end
