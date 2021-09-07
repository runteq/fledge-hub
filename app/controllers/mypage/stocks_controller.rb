module Mypage
  class StocksController < ApplicationController
    def index
      stock_products = current_user.stock_products
      @pagy, @stock_products = pagy(stock_products)
    end
  end
end
