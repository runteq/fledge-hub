require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  describe 'GET /show' do
    let(:product) { create(:product, :with_user) }
    subject { get product_url(product) }

    it 'renders a successful response' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    let!(:user) { create(:user) }
    subject { get '/products/new' }
    before { login_as(user) }

    it 'renders a successful response' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, users: [user]) }
    subject { get "/products/#{product.id}/edit" }
    before { login_as(user) }

    it 'render a successful response' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let!(:user) { create(:user) }
    before { login_as(user) }
    subject { post '/products', params: { product: attributes } }

    context 'with valid parameters' do
      let(:attributes) do
        {
          title: 'hoge',
          summary: '',
          url: '',
          source_url: '',
          released_on: Time.zone.today,
          product_type_id: 1,
          product_category_id: 1,
          technology_ids: [''],
        }
      end

      it 'creates a new Product' do
        expect { subject }.to change(Product, :count).by(1)
      end

      it '画像登録ページに遷移する' do
        subject
        expect(response).to redirect_to(new_product_product_image_url(Product.last))
      end
    end

    context 'with technology_ids' do
      let!(:technology) { create(:technology) }
      let!(:attributes) do
        {
          title: 'hoge',
          summary: '',
          url: '',
          source_url: '',
          released_on: Time.zone.today,
          product_type_id: 1,
          product_category_id: 1,
          technology_ids: [technology.id],
        }
      end

      it 'creates a new Product' do
        expect { subject }.to change(Product, :count).by(1)
      end

      it '中間テーブルを作成する' do
        expect { subject }.to change(ProductTechnology, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let!(:attributes) do
        {
          title: 'hoge',
        }
      end

      it 'does not create a new Product' do
        expect { subject }.not_to change(Product, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    let!(:user) { create(:user) }
    subject { patch "/products/#{product.id}", params: { product: attributes } }
    before { login_as(user) }

    context 'with valid parameters' do
      let!(:product) { create(:product, title: 'hoge', users: [user]) }
      let!(:attributes) do
        {
          title: 'foo',
        }
      end

      it 'updates the requested product' do
        expect { subject }.to change { product.reload.title }.to('foo').from('hoge')
      end

      it 'redirects to the product' do
        subject
        expect(response).to redirect_to(product_url(product))
      end
    end

    context '既にtechnologyと紐付いていて、違うtechnologyにしたとき' do
      let!(:previous_technology) { create(:technology) }
      let!(:new_technology) { create(:technology) }
      let!(:product) do
        create(:product, title: 'hoge', users: [user], technologies: [previous_technology])
      end
      let!(:attributes) do
        {
          title: 'hoge',
          summary: '',
          url: '',
          source_url: '',
          released_on: Time.zone.today,
          product_type_id: product.product_type_id,
          product_category_id: product.product_category_id,
          technology_ids: [new_technology.id],
        }
      end

      it '上書きされる' do
        expect { subject }.to change {
                                product.reload.technologies
                              }.to([new_technology]).from([previous_technology])
      end
    end

    context 'with invalid parameters' do
      let!(:product) { create(:product, title: 'hoge', users: [user]) }
      let!(:attributes) do
        {
          title: '',
        }
      end

      it 'does not update the requested product' do
        expect { subject }.not_to change { product.reload.title }.from('hoge')
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:user) { create(:user) }
    let!(:product) { create(:product, users: [user]) }
    subject { delete "/products/#{product.id}" }
    before { login_as(user) }

    specify do
      expect { subject }.to change(Product, :count).by(-1)
    end

    specify do
      expect { subject }.to change(UserProduct, :count).by(-1)
    end

    it 'redirects to the products list' do
      subject
      expect(response).to redirect_to(root_url)
    end
  end
end
