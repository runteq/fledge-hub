# frozen_string_literal: true

class ProductComponent < ViewComponent::Base
  def initialize(product:)
    super()
    @product = product
  end

  def top_image_url
    @product.top_image.product_image
  end

  def product_title
    @product.title
  end

  def product_released_on
    @product.released_on
  end

  def product_summary
    @product.summary
  end
end
