# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductDecorator, type: :decorator do
  describe '#release_day_message' do
    context 'リリース日が昨日の場合' do
      let(:product) { create(:product, :yesterday) }
      it 'releasedと表示される' do
        expect(decorate(product).release_day_message).to eq "#{product.released_on} released"
      end
    end

    context 'リリース日が今日の場合' do
      let(:product) { create(:product, :today) }
      it 'releasedと表示される' do
        expect(decorate(product).release_day_message).to eq "#{product.released_on} released"
      end
    end

    context 'リリース日が明日の場合' do
      let(:product) { create(:product, :tomorrow) }
      fit 'will be releasedと表示される' do
        expect(decorate(product).release_day_message).to \
          eq "#{product.released_on} will be released"
      end
    end
  end
end
