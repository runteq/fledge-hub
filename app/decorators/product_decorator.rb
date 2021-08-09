# frozen_string_literal: true

module ProductDecorator
  def release_day_message
    Time.zone.today < released_on ? "#{released_on} will be released" : "#{released_on} released"
  end
end
