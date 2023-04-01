module External
  class TwitterClient
    include Rails.application.routes.url_helpers

    def initialize
      self.default_url_options = ApplicationMailer.default_url_options
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = Rails.application.credentials.config[:twitter][:consumer_key]
        config.consumer_secret = Rails.application.credentials.config[:twitter][:consumer_secret]
        config.access_token = Rails.application.credentials.config[:twitter][:access_token]
        config.access_token_secret = Rails.application.credentials.config[:twitter][:access_token_secret]
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

    def post(text)
      @client.update(text)
    end
  end
end
