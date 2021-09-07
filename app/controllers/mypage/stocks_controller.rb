module Mypage
  class StocksController < ApplicationController
    def index
      products = current_user.stock_products.includes_query.order(created_at: :desc)
      @pagy, @products = pagy(products)
    end
  end
end
