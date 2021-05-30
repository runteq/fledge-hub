class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find_by!(screen_name: params[:screen_name])
  end
end
