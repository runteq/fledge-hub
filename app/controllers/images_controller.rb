class ImagesController < ApplicationController
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
      redirect_to product_path(@product), notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  def update
    @image = @product.images.find(params[:id])
    if @image.update(image_params)
      redirect_to product_path(@product), notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @image = @product.images.find(params[:id])
    @image.destroy!
    redirect_to product_path(@product), notice: 'Image was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def image_params
    params.require(:image).permit(:title, :description, :url)
  end
end
