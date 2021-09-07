class OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if login_from(provider)
      redirect_back_or_to root_path, notice: "#{provider.titleize}でログインしました。"
    else
      # データをセッションに入れる
      session[:user_info] = @user_hash[:user_info]
      redirect_to new_registration_path
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
