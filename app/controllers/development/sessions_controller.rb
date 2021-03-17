class Development::SessionsController < ApplicationController
  def login_as
    user = User.find(params[:user_id])
    auto_login(user)
    redirect_to root_path, notice: "#{Rails.env}環境でログインしました"
  end
end
