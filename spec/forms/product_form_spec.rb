require 'rails_helper'

RSpec.describe ProductForm do
  def build_form(product)
    # .findの後の状態
    ProductForm.new(
      id: product.id,
      title: product.title,
      url: product.url,
      source_url: product.source_url,
      released_on: product.released_on,
      summary: product.summary,
      product_category_id: product.product_category_id,
      product_type_id: product.product_type_id,
      technology_ids: product.technology_ids,
      user_ids: product.user_ids,
    )
  end

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
          source_url: 'https://example.com',
          released_on: '2021-06-17',
          summary: '',
          product_type_id: '1',
          product_category_id: '1',
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be false }
      it 'Productレコードを作成しない' do
        expect { subject }.not_to change(Product, :count)
      end
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ title: ['を入力してください'] })
      end
    end

    context '正常系' do
      let!(:user) { create(:user, :active) }
      let!(:technology) { create(:technology) }
      let!(:attributes) do
        {
          title: 'タイトル',
          url: '',
          source_url: 'https://example.com',
          released_on: '2021-06-17',
          summary: '',
          product_type_id: '1',
          product_category_id: '1',
          technology_ids: [technology.id.to_s],
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be true }
      it 'Productレコードと中間テーブルを作成する' do
        expect { subject }.to change(Product, :count).by(1)
                          .and change(UserProduct, :count).by(1)
                          .and change(ProductTechnology, :count).by(1)
      end
      it 'formのidに product#id を適用する' do
        subject
        expect(form.id).to eq(Product.last.id)
      end
    end

    describe 'メディアについて' do
      let!(:user) { create(:user, :active) }
      let!(:attributes) do
        {
          title: 'タイトル',
          url: '',
          source_url: 'https://example.com',
          released_on: '2021-06-17',
          summary: '',
          product_type_id: '1',
          product_category_id: '1',
          technology_ids: [],
          user_ids: [user.id],
          media_attributes: [media_attribute],
        }
      end

      context 'バリデーションエラーのとき' do
        let!(:media_attribute) do
          {
            id: '',
            title: '', # バリデーションエラー
            url: 'https://example.com',
          }
        end

        it { expect(subject).to be false }
        it 'ProductもProductMediumを作成しない' do
          expect { subject }.to not_change(Product, :count)
                            .and not_change(ProductMedium, :count)
        end
        it 'エラーメッセージを持つ' do
          subject
          expect(form.errors.messages).to eq({ media_attributes: ['の見出しを入力してください'] })
        end
      end

      context '正常系' do
        let!(:media_attribute) do
          {
            id: '',
            title: 'タイトル',
            url: 'https://example.com',
          }
        end

        it { expect(subject).to be true }
        it 'ProductMediumレコードを作成する' do
          expect { subject }.to change(ProductMedium, :count).by(1)
          expect(ProductMedium.last.attributes).to match(
            'title' => 'タイトル',
            'url' => 'https://example.com',
            'id' => be_a(Integer),
            'product_id' => be_a(Integer),
            'created_at' => be_a(ActiveSupport::TimeWithZone),
            'updated_at' => be_a(ActiveSupport::TimeWithZone),
          )
        end
      end
    end
  end

  describe '#to_model' do
    subject { form.to_model }
    let!(:form) { build_form(create(:product)) }

    it { is_expected.to be_a Product }
  end

  describe '#update' do
    subject { form.update(**attributes) }
    let!(:form) { build_form(product) }
    let!(:user) { create(:user) }
    let!(:product) { create(:product, title: '旧タイトル', users: [user]) }

    context 'バリデーションエラー時' do
      let!(:attributes) do
        {
          title: '新タイトル',
          url: '',
          source_url: 'https://example.com',
          released_on: '', # バリデーションエラー
          summary: '',
          product_category_id: '1',
          product_type_id: '1',
        }
      end

      it { expect(subject).to be false }
      it 'タイトルを変更しない' do
        expect { subject }.not_to change { product.reload.title }.from('旧タイトル')
      end
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ released_on: %w[を入力してください は日付ではありません] })
      end
    end

    context '正常系' do
      let!(:technology) { create(:technology) }
      let!(:attributes) do
        {
          title: '新タイトル',
          url: '',
          source_url: 'https://example.com',
          released_on: '2021-06-17',
          summary: '',
          product_category_id: '1',
          product_type_id: '1',
          technology_ids: [technology.id.to_s],
        }
      end

      it { expect(subject).to be true }
      it 'タイトルを変更する' do
        expect { subject }.to change { product.reload.title }.to('新タイトル').from('旧タイトル')
      end
      it 'userによるproductのまま' do
        expect(product.reload.users).to eq [user]
        subject
        expect(product.reload.users).to eq [user]
      end
    end

    describe 'メディアについて' do
      let!(:medium) { create(:product_medium, product: product, title: '旧タイトル') }
      let!(:attributes) do
        {
          title: '新タイトル',
          url: '',
          source_url: 'https://example.com',
          released_on: '2021-06-17',
          summary: '',
          product_type_id: '1',
          product_category_id: '1',
          technology_ids: [],
          user_ids: [user.id],
          media_attributes: media_attributes,
        }
      end

      context 'バリデーションエラーのとき' do
        let!(:media_attributes) do
          [
            {
              id: medium.id,
              title: '', # バリデーションエラー
              url: 'https://example.com',
            },
          ]
        end

        it { expect(subject).to be false }
        it 'productもmediumも変更しない' do
          expect { subject }.to not_change { product.reload.title }.from('旧タイトル')
                            .and not_change { product.media.first.reload.title }.from('旧タイトル')
        end
        it 'エラーメッセージを持つ' do
          subject
          expect(form.errors.messages).to eq({ media_attributes: ['の見出しを入力してください'] })
        end
      end

      context '正常系' do
        let!(:media_attributes) do
          [
            {
              id: medium.id,
              title: '新タイトル',
              url: 'https://example.com',
            },
          ]
        end

        it { expect(subject).to be true }
        it 'productとmediumのレコードを更新する' do
          expect { subject }.to change { product.reload.title }.to('新タイトル').from('旧タイトル')
          .and change { medium.reload.title }.to('新タイトル').from('旧タイトル')
        end
      end

      context 'ProductMediumレコードの追加' do
        let!(:media_attributes) do
          [
            {
              id: medium.id,
              title: medium.title,
              url: medium.url,
            },
            {
              id: '',
              title: '新しいProductMedium',
              url: 'https://example.com',
            },
          ]
        end

        it { expect(subject).to be true }
        it { expect { subject }.to change(ProductMedium, :count).by(1) }
      end

      context 'ProductMediumレコードの削除' do
        let!(:media_attributes) do
          []
        end

        it { expect(subject).to be true }
        it { expect { subject }.to change(ProductMedium, :count).by(-1) }
      end
    end
  end

  describe '#media' do
    subject { form.media }
    let!(:form) { build_form(product) }
    let!(:product) { create(:product) }

    context '該当IDのProductMediumが既に存在するとき' do
      let!(:medium) { create(:product_medium, product: product) }
      before do
        allow_any_instance_of(ProductForm).to receive(:media_attributes).and_return(
          [
            {
              id: medium.id,
              title: medium.title,
              url: medium.url,
            },
          ],
        )
      end
      it '既存のProductMediumの配列を返す' do
        is_expected.to eq [medium]
      end
    end

    context 'IDがない（新しいレコード）とき' do
      before do
        allow_any_instance_of(ProductForm).to receive(:media_attributes).and_return(
          [
            {
              id: '',
              title: 'タイトル',
              url: 'https://example.com',
            },
          ],
        )
      end
      it '新たに作られたProductMediumの配列を返す' do
        is_expected.to be_an(Array)
        expect(subject.first).to be_a_new(ProductMedium)
      end
    end
  end

  describe '#url_validity' do
    context '存在しないURLのとき' do
      subject { form.save }
      let!(:form) { ProductForm.new(**attributes) }
      let!(:user) { create(:user, :active) }
      let!(:attributes) do
        {
          title: 'タイトル',
          url: "https://#{SecureRandom.urlsafe_base64}.com",
          source_url: 'https://example.com',
          released_on: '2021-06-17',
          summary: '',
          product_type_id: '1',
          product_category_id: '1',
          technology_ids: [],
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be false }
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ url: ['にアクセスできません。'] })
      end
    end
  end
end
