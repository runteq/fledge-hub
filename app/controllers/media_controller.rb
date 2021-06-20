class MediaController < ApplicationController
  before_action :require_login
  before_action :set_product

  def new
    @medium = @product.media.build
  end

  def edit
    @medium = @product.media.find(params[:id])
  end

  def create
    @medium = @product.media.build(medium_params)

    if @medium.save
      redirect_to product_path(@product), notice: 'medium was successfully created.'
    else
      render :new, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def update
    @medium = @product.media.find(params[:id])
    if @medium.update(medium_params)
      redirect_to product_path(@product), notice: 'medium was successfully updated.'
    else
      render :edit, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def destroy
    @medium = @product.media.find(params[:id])
    @medium.destroy!
    redirect_to product_path(@product), notice: 'medium was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def medium_params
    params.require(:medium).permit(:title, :url)
  end
end
