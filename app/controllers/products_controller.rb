class ProductsController < ApplicationController
  before_action :require_login, only: %i[new edit create update destroy]

  def index
    @q = Product.order(created_at: :desc).ransack(params[:q])
    result = @q.result(distinct: true).includes_query
    @pagy, @products = pagy(result, items: 29)
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images.with_attached_product_image
  end

  def new
    @product_form = ProductForm.new
  end

  def edit
    @product_form = ProductForm.find(params[:id], current_user.id)
  end

  def create
    @product_form = ProductForm.new(product_params.merge(user_ids: [current_user.id]))
    if @product_form.save
      product = @product_form.to_model
      text = External::TwitterClient.posted_notification_text(product)
      TweetForm.new(text: text, url: product_url(product)).save!
      redirect_to new_product_product_image_path(@product_form), notice: 'サービスを投稿しました！'
    else
      render :new, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def update
    @product_form = ProductForm.find(params[:id], current_user.id)
    if @product_form.update(product_params)
      redirect_to product_path(@product_form), notice: 'データを更新しました！'
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
