# frozen_string_literal: true

module ProductDecorator
  def release_day_message
    Time.zone.today < released_on ? "#{released_on} will be released" : "#{released_on} released"
  end

  def to_meta_tags
    {
      title: title,
      description: summary,
      keywords: "#{product_type.name},#{product_category.name},#{technologies.pluck(:name).join(',')}",
      og: {
        title: :full_title,
        image: product_thumbnail_url(top_image),
      },
      twitter: {
        title: :full_title,
        image: product_thumbnail_url(top_image),
      },
    }
  end
end
