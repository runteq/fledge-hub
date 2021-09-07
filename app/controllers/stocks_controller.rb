class StocksController < ApplicationController
  before_action :require_login

  def create
    current_user.stocks.find_or_create_by(product_id: params[:product_id])
    render status: :created
  end

  def destroy
    stock = current_user.stocks.find_by!(product_id: params[:product_id])
    stock.destroy!
    render status: :ok
  end
end
