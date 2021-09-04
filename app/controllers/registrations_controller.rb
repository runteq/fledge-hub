class RegistrationsController < ApplicationController
  before_action :require_not_login

  def new
    user_info = session[:user_info]
    @user = User.new(
      screen_name: user_info['login'],
      display_name: user_info['name'],
      email: user_info['email'],
    )
  end

  def create
    user_info = session[:user_info]
    avatar_url = URI.parse(user_info['avatar_url'])
    @user = User.new(user_params)

    # フロントで同意するを制御するようにしたら削除する
    # https://github.com/runteq/fledge-hub/issues/158
    unless params[:acceptable]
      flash.now[:alert] = '利用規約に同意してください'
      return render :new, status: :unprocessable_entity
    end

    if @user.registration(avatar_url, user_info)
      reset_session
      auto_login(@user)
      redirect_back_or_to root_path, notice: '登録しました'
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
