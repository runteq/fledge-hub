# frozen_string_literal: true

class ProductComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(product:, product_counter:)
    super()
    @product = product
    @product_counter = product_counter
  end

  private

  attr_reader :product, :product_counter
end
