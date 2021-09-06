require 'rails_helper'

RSpec.describe ProductComponent, type: :component do
  context 'productが存在する時' do
    let!(:product) { create(:product, :with_user) }
    it 'ComponentにProductのtitleが含まれていること' do
      render_inline(described_class.new(product: product))
      expect(rendered_component).to have_text product.title
    end
  end
end
