class UsersController < ApplicationController
  def index
    users = User.active
                .joins(:user_products)
                .with_attached_avatar
                .select('users.*, COUNT(user_products.id) AS count_of_products')
                .group(:id)
                .order(created_at: :desc)
    @pagy, @users = pagy(users, items: 30)
  end

  def show
    @user = User.active.find_by!(screen_name: params[:screen_name])
    @social_accounts = SocialAccount.sorted(@user.social_accounts)

    @products = @user.products.includes(:technologies,
                                        { images: { product_image_attachment: :blob } })
                     .order(released_on: :desc)
  end
end
