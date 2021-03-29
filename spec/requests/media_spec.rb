require 'rails_helper'

RSpec.describe "/products/:product_id/media", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  before { login_as(user) }

  describe "GET /new" do
    it "renders a successful response" do
      get "/products/#{product.id}/media/new"
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      medium = create(:medium, product: product)
      get "/products/#{product.id}/media/#{medium.id}/edit"
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    subject { post "/products/#{product.id}/media", params: { medium: attributes } }
    context "with valid parameters" do
      let(:attributes) do
        {
          title: 'タイトル',
          url: Faker::Internet.url
        }
      end

      it "creates a new medium" do
        expect { subject }.to change(Medium, :count).by(1)
      end

      it "redirects to the created medium" do
        subject
        expect(response).to redirect_to("/products/#{product.id}")
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: 'タイトル',
          url: ''
        }
      end

      it "does not create a new medium" do
        expect { subject }.to change(Medium, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        subject
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    let(:medium) { create(:medium, title: '古いタイトル', product: product) }
    subject { patch "/products/#{product.id}/media/#{medium.id}", params: { medium: attributes } }
    context "with valid parameters" do
      let(:attributes) do
        {
          title: '新しいタイトル'
        }
      end

      it "updates the requested medium" do
        expect { subject }.to change { medium.reload.title }.to('新しいタイトル').from('古いタイトル')
      end

      it "redirects to the medium" do
        subject
        medium.reload
        expect(response).to redirect_to("/products/#{product.id}")
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: ''
        }
      end

      it "does not update the requested medium" do
        expect { subject }.not_to change { medium.reload.title }.from('古いタイトル')
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        subject
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:medium) { create(:medium, product: product) }
    subject { delete "/products/#{product.id}/media/#{medium.id}" }

    it "destroys the requested medium" do
      expect { subject }.to change(Medium, :count).by(-1)
    end

    it "redirects to the media list" do
      subject
      expect(response).to redirect_to("/products/#{product.id}")
    end
  end
end
