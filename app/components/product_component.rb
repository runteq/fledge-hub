# frozen_string_literal: true

class ProductComponent < ViewComponent::Base
  include LinkHelper

  def initialize(product:)
    super()
    @product = product
  end

  private

  attr_reader :product
end
