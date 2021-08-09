# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductDecorator do
  let(:product) { Product.new.extend ProductDecorator }
  subject { product }
  it { should be_a Product }
end
