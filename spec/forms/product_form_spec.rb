require 'rails_helper'

RSpec.describe ProductForm do
  describe '.find' do
    subject { ProductForm.find(product.id, user.id) }
    context 'userによるproductではないとき' do
      let!(:user) { create(:user) }
      let!(:product) { create(:product) }
      it 'ActiveRecord::RecordNotFoundをraiseする' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'userによるproductのとき' do
      let!(:user) { create(:user) }
      let!(:product) { create(:product, users: [user]) }

      it { is_expected.to be_a ProductForm }
      it 'productのattributeをもつ' do
        # titleしか確認していない
        expect(subject.title).to eq product.title
      end
    end
  end

  describe '#save' do
    subject { form.save }
    let!(:form) { ProductForm.new(**attributes) }

    context 'バリデーションエラー時' do
      let!(:user) { create(:user, :active) }
      let!(:attributes) do
        {
          title: '', # バリデーションエラー
          url: '',
          source_url: '',
          released_on: '2021-06-17',
          summary: '',
          genre_id: '', # バリデーションエラー
          technology_ids: [''],
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be false }
      it 'レコードを作成しない' do
        expect { subject }.not_to change(Product, :count)
      end
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ title: ['を入力してください'], genre_id: ['を入力してください'] })
      end
    end

    context '正常系' do
      let!(:user) { create(:user, :active) }
      let!(:technology) { create(:technology) }
      let!(:attributes) do
        {
          title: 'タイトル',
          url: '',
          source_url: '',
          released_on: '2021-06-17',
          summary: '',
          genre_id: '1',
          technology_ids: [technology.id.to_s],
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be true }
      it 'レコードを作成する' do
        expect { subject }.to change(Product, :count).by(1)
                          .and change(UserProduct, :count).by(1)
                          .and change(ProductTechnology, :count).by(1)
      end
    end
  end

  describe '#to_model' do
    subject { form.to_model }
    let!(:form) { ProductForm.new(**attributes) }
    let!(:attributes) do
      {
        title: 'タイトル',
        url: 'URL',
        source_url: '',
        released_on: '2021-06-17',
        summary: '',
        genre_id: '1',
        technology_ids: [],
        user_ids: [],
      }
    end

    it { is_expected.to be_a Product }
    specify do
      expect(subject.attributes.deep_symbolize_keys).to match(
        id: nil,
        title: 'タイトル',
        url: 'URL',
        source_url: '',
        released_on: Date.parse('2021-06-17'),
        summary: '',
        genre_id: 1,
        created_at: nil,
        updated_at: nil,
      )
    end
  end
end
