require 'rails_helper'

RSpec.describe ProductImagesController, type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, users: [user]) }
  before { login_as(user) }

  describe 'GET /new' do
    it 'renders a successful response' do
      get "/products/#{product.id}/product_images/new"
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      image = create(:product_image, product: product)
      get "/products/#{product.id}/product_images/#{image.id}/edit"
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject { post "/products/#{product.id}/product_images", params: { product_image: attributes } }
    context 'with valid parameters' do
      let(:attributes) do
        {
          product_image: fixture_file_upload('images/720x400.png'),
        }
      end

      it 'creates a new Image' do
        expect { subject }.to change(ProductImage, :count).by(1)
      end

      it 'redirects to the created image' do
        subject
        expect(response).to redirect_to("/products/#{product.id}")
      end
    end

    context 'with invalid parameters' do
      let(:attributes) do
        {
          product_image: nil,
        }
      end

      it 'does not create a new Image' do
        expect { subject }.to change(ProductImage, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    let(:product_image) do
      create(
        :product_image,
        product_image: fixture_file_upload('images/720x400.png'),
        product: product,
      )
    end
    subject do
      patch "/products/#{product.id}/product_images/#{product_image.id}",
            params: { product_image: attributes }
    end
    context 'with valid parameters' do
      let(:attributes) do
        {
          product_image: fixture_file_upload('images/200x200.png'),
        }
      end

      it 'updates the requested image' do
        expect { subject }.to change { product_image.reload.product_image.id }
      end

      it 'redirects to the image' do
        subject
        product_image.reload
        expect(response).to redirect_to("/products/#{product.id}")
      end
    end

    context 'with invalid parameters' do
      let(:attributes) do
        {
          product_image: nil,
        }
      end

      it 'does not update the requested image' do
        expect { subject }.not_to change { product_image.reload.product_image.id }
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:product_image) { create(:product_image, product: product) }
    subject { delete "/products/#{product.id}/product_images/#{product_image.id}" }

    it 'destroys the requested image' do
      expect { subject }.to change(ProductImage, :count).by(-1)
    end

    it 'redirects to the images list' do
      subject
      expect(response).to redirect_to("/products/#{product.id}")
    end
  end
end
