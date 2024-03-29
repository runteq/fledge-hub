require 'rails_helper'

RSpec.describe ProductComponent, type: :component do
  context 'productが存在する時' do
    let!(:product) { create(:product, :with_user) }
    it 'ComponentにProductのtitleが含まれていること' do
      render_inline(described_class.new(product: product, product_counter: nil))
      expect(rendered_component).to have_text product.title
    end
  end

  context '4番目の要素の時' do
    context 'ad_flagがfalseのとき' do
      let!(:product) { create(:product, :with_user) }
      it 'Componentに広告表示が含まれていないこと' do
        render_inline(described_class.new(product: product, product_counter: 4, ad_flag: false))
        expect(rendered_component).not_to have_css '#ad'
      end
    end

    context 'ad_flagがtrueのとき' do
      let!(:product) { create(:product, :with_user) }
      it 'Componentに広告表示が含まれていること' do
        render_inline(described_class.new(product: product, product_counter: 4, ad_flag: true))
        expect(rendered_component).to have_css '#ad'
      end
    end
  end
end
