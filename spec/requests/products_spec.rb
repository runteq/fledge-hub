require 'rails_helper'

RSpec.describe "/products", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do
    before { create(:product, users: [user]) }

    it "renders a successful response" do
      get products_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:product) { create(:product, users: [user]) }
    subject { get product_url(product) }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    subject { get new_product_url }
    before { login_as(user) }

    it "renders a successful response" do
      subject
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let(:product) { create(:product, users: [user]) }
    subject { get edit_product_url(product) }
    before { login_as(user) }

    it "render a successful response" do
      subject
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before { login_as(user) }
    subject { post products_url, params: { product: attributes } }

    context "with valid parameters" do
      let(:attributes) do
        {
          title: 'hoge',
          summary: '',
          url: '',
          source_url: '',
          released_on: Time.zone.today
        }
      end

      it "creates a new Product" do
        expect { subject }.to change(Product, :count).by(1)
      end

      it "redirects to the created product" do
        subject
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: 'hoge',
        }
      end

      it "does not create a new Product" do
        expect { subject }.to change(Product, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        subject
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    before { login_as(user) }
    let(:product) { create(:product, title: 'hoge', users: [user]) }
    subject { patch product_url(product), params: { product: attributes } }

    context "with valid parameters" do
      let(:attributes) do
        {
          title: 'foo',
        }
      end

      it "updates the requested product" do
        expect { subject }.to change { product.reload.title }.to('foo').from('hoge')
      end

      it "redirects to the product" do
        subject
        expect(response).to redirect_to(product_url(product))
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: '',
        }
      end

      it "does not update the requested product" do
        expect { subject }.not_to change { product.reload.title }.from('hoge')
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        subject
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:product) { create(:product, users: [user]) }
    subject { delete product_url(product) }
    before { login_as(user) }

    specify do
      expect { subject }.to change(Product, :count).by(-1)
    end

    specify do
      expect { subject }.to change(UserProduct, :count).by(-1)
    end

    it "redirects to the products list" do
      subject
      expect(response).to redirect_to(products_url)
    end
  end
end
