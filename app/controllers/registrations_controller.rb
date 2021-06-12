class RegistrationsController < ApplicationController
  before_action :require_not_login

  def new
    user_info = session[:user_info]
    @user = User.new(
      screen_name: user_info['login'],
      display_name: user_info['name'],
      email: user_info['email']
    )
  end

  def create
    user_info = session[:user_info]
    avatar_url = URI.parse(user_info['avatar_url'])
    @user = User.new(user_params)
    if @user.registration(avatar_url, user_info['id'])
      reset_session
      auto_login(@user)
      redirect_back_or_to root_path, notice: 'ログインしました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_not_login
    redirect_to root_path if logged_in? || session[:user_info].nil?
  end

  def user_params
    params.require(:user).permit(:screen_name, :display_name, :email)
  end
end
