class StocksController < ApplicationController
  def create
    current_user.stocks.create!(product_id: params[:product_id])
  end

  def destroy
    stock = current_user.stocks.find_by!(product_id: params[:product_id])
    stock.destroy!
  end
end
