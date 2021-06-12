class OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if login_from(provider)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    else
      create_user_from(provider)
      auto_login(user)
      redirect_to root_path, notice: "#{provider.titleize}で新規登録しました"
    end
  end

  private

  def create_user_from(provider)
    # display_nameが登録されていないときはscreen_nameを使う
    @user_hash[:user_info]['name'] ||= @user_hash[:user_info]['login']
    url = URI.parse(@user_hash[:user_info]['avatar_url'])
    user = create_from(provider)
    user.grab_avatar_image(url)
    reset_session
  end

  def auth_params
    params.permit(:code, :provider)
  end
end
