class SearchesController < ApplicationController
  def new
    @q = Product.order(created_at: :desc).ransack(params[:q])
  end
end
