class OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    if auth_params[:error] == 'access_denied'  # GitHub認証キャンセル
      redirect_to root_path, notice: 'ログインをキャンセルしました'
      return
    end

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
    params.permit(:code, :provider, :error)
  end
end
