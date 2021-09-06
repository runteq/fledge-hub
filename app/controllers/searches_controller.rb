class SearchesController < ApplicationController
  def show
    search_result = SearchProductsForm.search(search_params)
    products = search_result.includes(:technologies,
                                      :users, { images: { product_image_attachment: :blob } })
                            .order(created_at: :desc)
    @pagy, @products = pagy(products)
  end

  private

  def search_params
    params.fetch(:q, {}).permit(:title)
  end
end
