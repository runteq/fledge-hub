require 'rails_helper'

RSpec.describe SearchProductsForm do
  describe '#search_title' do
    subject { SearchProductsForm.search(title: title) }

    before do
      create(:product, title: 'ぷろだくと')
      create(:product, title: 'プロダクト')
      create(:product, title: '非検索対象')
    end

    context 'ひらがなで検索した場合' do
      let!(:title) { 'ぷろだくと' }

      it 'ひらがな・カタカナを問わず検索されること' do
        expect(subject.length).to eq 2
      end
    end

    context 'カタカナで検索した場合' do
      let!(:title) { 'プロダクト' }

      it 'ひらがな・カタカナを問わず検索されること' do
        expect(subject.length).to eq 2
      end
    end

    context 'プロダクト名の一部で検索した場合' do
      let!(:title) { 'ダク' }

      it '検索名を含むプロダクトが検索されること' do
        expect(subject.length).to eq 2
      end
    end

    context 'ヒットするプロダクトが存在しない場合' do
      let!(:title) { 'ヒットせず' }

      it '何のプロダクトも返らないこと' do
        expect(subject.length).to eq 0
      end
    end
  end
end
