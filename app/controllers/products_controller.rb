class ProductsController < ApplicationController
  before_action :require_login, only: %i[new edit create update destroy]

  def index
    products = Product.includes_query.order(created_at: :desc)
    @pagy, @products = pagy(products)
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images.with_attached_product_image
  end

  def new
    @product = ProductForm.new
  end

  def edit
    @product = ProductForm.find(params[:id], current_user.id)
  end

  def create
    @product = ProductForm.new(product_params.merge(user_ids: [current_user.id]))
    if @product.save
      redirect_to product_path(@product), notice: 'サービスを投稿しました！'
    else
      render :new, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def update
    @product = ProductForm.find(params[:id], current_user.id)
    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'データを更新しました！'
    else
      render :edit, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy!
    redirect_to root_url, notice: 'サービスを削除しました！'
  end

  private

  def product_params
    params.require(:product).permit(
      :title,
      :summary,
      :url,
      :source_url,
      :released_on,
      :product_category_id,
      :product_type_id,
      technology_ids: [],
      media_attributes: %i[id title url],
    )
  end
end
