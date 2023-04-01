class TweetForm
  include ActiveModel::Model

  attr_accessor :text, :url

  validates :text, presence: true, length: { maximum: 117 }
  validates :url, presence: true, url: { schemes: %w[https http] }

  def save!
    validate!

    if Rails.env.production?
      External::TwitterClient.new.post("#{text}\n#{url}")
    else
      Rails.logger.info "Post to twitter.\n#{text}"
    end
  end
end
