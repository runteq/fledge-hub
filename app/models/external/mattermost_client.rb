module External
  class MattermostClient
    SERVER_URL = 'https://chat.runteq.jp'.freeze
    WEBHOOK_URL = Rails.application.credentials.mattermost[:webhook_url]

    class << self
      def client
        Faraday::Connection.new(url: SERVER_URL) do |faraday|
          faraday.request :url_encoded
          faraday.response :raise_error
          faraday.headers['Content-Type'] = 'application/json'
          faraday.adapter Faraday.default_adapter
        end
      end

      def post(payload)
        client.post do |req|
          req.url WEBHOOK_URL
          req.headers['Content-Type'] = 'application/json'
          req.body = payload.to_json
        end
      end
    end
  end
end
