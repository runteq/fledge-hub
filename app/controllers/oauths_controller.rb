class OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if login_from(provider)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    else
      @user_hash[:user_info]['name'] ||= @user_hash[:user_info]['login']
      user = create_from(provider)
      reset_session
      auto_login(user)
      redirect_to root_path, notice: "#{provider.titleize}で新規登録しました"
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
