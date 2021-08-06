class ProductsController < ApplicationController
  before_action :require_login, only: %i[new edit create update destroy]
  include Pagy::Backend

  def index
    @search_form = SearchProductsForm.new(search_params)
    @pagy, @products = pagy(@search_form.search
                            .includes(:technologies,
                                      :users, { images: { product_image_attachment: :blob } })
                            .order(created_at: :desc))
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
      redirect_to product_path(@product), notice: '投稿しました！'
    else
      render :new, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def update
    @product = ProductForm.find(params[:id], current_user.id)
    if @product.update(product_params)
      redirect_to product_path(@product), notice: '更新しました！'
    else
      render :edit, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy!
    redirect_to products_url, notice: 'Product was successfully destroyed.'
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

  def search_params
    params.fetch(:search, {}).permit(:title)
  end
end
