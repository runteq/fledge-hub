# frozen_string_literal: true

class AdComponent < ViewComponent::Base
  include LinkHelper

  def initialize
    super

    @ad_banner = AdBanner.find(AdBanner.all.pluck(:id).sample)
  end
end
