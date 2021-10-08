class ProductImagesController < ApplicationController
  before_action :require_login
  before_action :set_product

  def new
    @image = @product.images.build
  end

  def edit
    @image = @product.images.find(params[:id])
  end

  def create
    @image = @product.images.build(image_params)

    if @image.save
      redirect_to product_path(@product), notice: '画像を追加しました！'
    else
      render :new, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def update
    @image = @product.images.find(params[:id])
    if @image.update(image_params)
      redirect_to product_path(@product), notice: '画像を変更しました！'
    else
      render :edit, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def destroy
    @image = @product.images.find(params[:id])
    @image.destroy!
    redirect_to product_path(@product), notice: '画像を削除しました！'
  end

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end

  def image_params
    params.require(:product_image).permit(:product_image)
  end
end
