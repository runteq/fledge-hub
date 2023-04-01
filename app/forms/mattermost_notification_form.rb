class MattermostNotificationForm
  include ActiveModel::Model

  attr_accessor :username, :channel, :text

  validates :username, presence: true
  validates :channel, presence: true
  validates :text, presence: true

  def save!
    validate!

    post_to_mattermost
  end

  private

  def post_to_mattermost
    post_payload = { username: username, channel: channel, text: text }

    if Rails.env.production?
      External::MattermostClient.new.post(post_payload)
    else
      Rails.logger.info "Message to Mattermost.\n#{post_payload}"
    end
  end
end
