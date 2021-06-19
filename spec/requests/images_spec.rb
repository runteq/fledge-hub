require 'rails_helper'

RSpec.describe ImagesController, type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  before { login_as(user) }

  describe "GET /new" do
    it "renders a successful response" do
      get "/products/#{product.id}/images/new"
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      image = create(:image, product: product)
      get "/products/#{product.id}/images/#{image.id}/edit"
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    subject { post "/products/#{product.id}/images", params: { image: attributes } }
    context "with valid parameters" do
      let(:attributes) do
        {
          product_image: fixture_file_upload('images/720x400.png')
        }
      end

      it "creates a new Image" do
        expect { subject }.to change(Image, :count).by(1)
      end

      it "redirects to the created image" do
        subject
        expect(response).to redirect_to("/products/#{product.id}")
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          product_image: nil
        }
      end

      it "does not create a new Image" do
        expect { subject }.to change(Image, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    let(:image) { create(:image, description: '古い説明', product: product) }
    subject { patch "/products/#{product.id}/images/#{image.id}", params: { image: attributes } }
    context "with valid parameters" do
      let(:attributes) do
        {
          description: '新しい説明'
        }
      end

      it "updates the requested image" do
        expect { subject }.to change { image.reload.description }.to('新しい説明').from('古い説明')
      end

      it "redirects to the image" do
        subject
        image.reload
        expect(response).to redirect_to("/products/#{product.id}")
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          description: '新しい説明',
          product_image: nil
        }
      end

      it "does not update the requested image" do
        expect { subject }.not_to change { image.reload.description }.from('古い説明')
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:image) { create(:image, product: product) }
    subject { delete "/products/#{product.id}/images/#{image.id}" }

    it "destroys the requested image" do
      expect { subject }.to change(Image, :count).by(-1)
    end

    it "redirects to the images list" do
      subject
      expect(response).to redirect_to("/products/#{product.id}")
    end
  end
end
