class SearchesController < ApplicationController
  def show
    search_form = SearchProductsForm.new(search_params)
    products = search_form.search
                          .includes(:technologies,
                                    :users, { images: { product_image_attachment: :blob } })
                          .order(created_at: :desc)
    @pagy, @products = pagy(products)
  end

  private

  def search_params
    params.fetch(:q, {}).permit(:title)
  end
end
