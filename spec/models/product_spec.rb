# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  released_on :date             not null
#  source_url  :text(65535)      not null
#  summary     :text(65535)      not null
#  title       :string(255)      not null
#  url         :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#permitted_edit?' do
    let!(:product) { create(:product) }
    subject { product.permitted_edit?(user) }

    context '自分によるproductではないとき' do
      let!(:user) { create(:user) }
      it { is_expected.to eq false }
    end

    context '自分のproductのとき' do
      let!(:user) { create(:user, products: [product]) }
      it { is_expected.to eq true }
    end

    context 'userがnilのとき' do
      let!(:user) { nil }
      it { is_expected.to eq false }
    end
  end
end
