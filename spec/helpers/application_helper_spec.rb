require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#product_thumbnail_url' do
    context '引数がnilのとき' do
      subject { helper.product_thumbnail_url(nil) }
      it { is_expected.to eq ProductImage::NO_IMAGE_URL }
    end

    context '引数がないとき' do
      let!(:product_image) { create(:product_image) }
      subject { helper.product_thumbnail_url(product_image) }
      it '800×450の画像URLを返す' do
        is_expected.to eq url_for(product_image.product_image.variant(resize_to_fill: [800, 450]))
      end
    end
  end
end
