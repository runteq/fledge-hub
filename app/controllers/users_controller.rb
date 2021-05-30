class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by!(screen_name: params[:screen_name])
    @products = @user.products.includes(:technologies, { images: { product_image_attachment: :blob } })
  end
end
