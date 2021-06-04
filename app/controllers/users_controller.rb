class UsersController < ApplicationController
  def index
    @users = User.active.order(created_at: :desc)
  end

  def show
    @user = User.active.find_by!(screen_name: params[:screen_name])

    @products = @user.products.includes(:technologies, { images: { product_image_attachment: :blob } })
  end
end
