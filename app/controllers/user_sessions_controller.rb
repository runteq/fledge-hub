class UserSessionsController < ApplicationController
  before_action :require_login

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
