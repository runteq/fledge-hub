require "rails_helper"

RSpec.describe ProductComponent, type: :component do
  context "productが存在する時" do
  let(:product) { create(:product) }
    it "ComponentにProductのtitleが含まれていること" do
      render_inline(described_class.new(product: product))
      expect(rendered_component).to have_text "プロダクト_1"
    end
  end
  context "productが存在しない時" do
    xit "ComponentにProductのtitleが含まれていないこと"
  end
end
