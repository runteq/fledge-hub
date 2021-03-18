require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#permitted_edit?' do
    let(:product) { create(:product) }
    subject { product.permitted_edit?(user) }

    context '自分によるproductではないとき' do
      let(:user) { create(:user) }
      it { is_expected.to eq false }
    end

    context '自分のproductのとき' do
      let(:user) { create(:user, products: [product]) }
      it { is_expected.to eq true }
    end

    context 'userがnilのとき' do
      let(:user) { nil }
      it { is_expected.to eq false }
    end
  end
end
