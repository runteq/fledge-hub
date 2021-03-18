class ProductsController < ApplicationController
  before_action :require_login, only: %i[new edit create update destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def create
    # 一対多みたいな書き方をしている。user複数のときどうするかは後々
    @product = current_user.products.build(product_params)
    if @product.valid?
      @product = current_user.products.create(product_params)
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    @product = current_user.products.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy!
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :url, :sourse_url, :released_on)
  end
end