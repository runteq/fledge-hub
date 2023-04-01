class TweetForm
  include ActiveModel::Model

  attr_accessor :text, :url

  validates :text, presence: true, length: { maximum: 117 }
  validates :url, presence: true, url: { schemes: %w[https http] }

  # ツイートするテキストを整形する
  def self.posted_notification_text(product)
    names_text = product.users.map do |u|
      u.twitter_name ? "@#{u.twitter_name}" : u.display_name
    end.join(' ')
    summary_length = 110 - (product.title.length + names_text.length + 26) # 余裕を持って文字数調整
    summary = product.summary[0..summary_length]
    "#FledgeHub に新規投稿されました！「#{product.title}」by #{names_text}\n#{summary}"
  end

  def save!
    validate!

    if Rails.env.production?
      External::TwitterClient.new.post("#{text}\n#{url}")
    else
      Rails.logger.info "Post to twitter.\n#{text}"
    end
  end
end
