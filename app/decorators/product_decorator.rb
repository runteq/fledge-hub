# frozen_string_literal: true

module ProductDecorator
  def release_day_message
    Time.zone.today < released_on ? "#{released_on} will be released" : "#{released_on} released"
  end

  def to_meta_tags
    {
      title: title,
      description: summary,
      keywords:
        "#{product_type.name},#{product_category.name},#{technologies.pluck(:name).join(',')}",
      og: {
        title: :full_title,
        image: ogp_url,
      },
      twitter: {
        title: :full_title,
        image: ogp_url,
      },
    }
  end

  def ogp_url
    return rails_representation_url(top_image.product_image.variant(resize_to_fill: [800, 450])) if top_image

    ProductImage::NO_IMAGE_URL
  end
end
