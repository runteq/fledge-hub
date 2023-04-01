module External
  class TwitterClient
    include Rails.application.routes.url_helpers
    POST_TWEET_URL = 'https://api.twitter.com/2/tweets'.freeze

    def initialize
      self.default_url_options = ApplicationMailer.default_url_options
      options = {
        consumer_key: Rails.application.credentials.config[:twitter][:consumer_key],
        consumer_secret: Rails.application.credentials.config[:twitter][:consumer_secret],
        token: Rails.application.credentials.config[:twitter][:access_token],
        token_secret: Rails.application.credentials.config[:twitter][:access_token_secret],
      }
      @client = Faraday.new(url: POST_TWEET_URL) do |faraday|
        faraday.request :oauth, options
        faraday.response :raise_error
        faraday.headers['Content-Type'] = 'application/json'
        faraday.adapter Faraday.default_adapter
      end
    end

    class << self
      # ツイートするテキストを整形する
      def posted_notification_text(product)
        names_text = product.users.map do |u|
          u.twitter_name ? "@#{u.twitter_name}" : u.display_name
        end.join(' ')
        summary_length = 110 - (product.title.length + names_text.length + 26) # 余裕を持って文字数調整
        summary = product.summary[0..summary_length]
        "#FledgeHub に新規投稿されました！「#{product.title}」by #{names_text}\n#{summary}"
      end
    end
  end

  def post(text)
    payload = { text: text }.to_json
    @client.post do |request|
      request.body = payload
    end
  end
end
