class SearchesController < ApplicationController
  def show
    search_result = SearchProductsForm.search(search_params)
    products = search_result.includes_query.order(created_at: :desc)
    @pagy, @products = pagy(products)
  end

  private

  def search_params
    params.fetch(:q, {}).permit(:title, :product_type_id, :product_category_id)
  end
end
