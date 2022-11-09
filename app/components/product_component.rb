# frozen_string_literal: true

class ProductComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(product:, product_counter:, ad_flag: false)
    super()
    @product = product
    @product_counter = product_counter
    @show_ad = ad_flag && product_counter == 4
  end

  private

  attr_reader :product, :product_counter
end
