class StocksController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    current_user.stocks.find_or_create_by(product_id: @product.id)
    render turbo_stream: turbo_stream.replace(
      'stock-button',
      partial: 'stocks/stock_button',
      locals: { product: @product, stocked: true },
    )
  end

  def destroy
    @product = Product.find(params[:product_id])
    stock = current_user.stocks.find_by!(product_id: @product.id)
    stock.destroy!
    render turbo_stream: turbo_stream.replace(
      'stock-button',
      partial: 'stocks/stock_button',
      locals: { product: @product, stocked: false },
    )
  end
end
