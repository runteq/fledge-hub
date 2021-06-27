class ApplicationController < ActionController::Base
  protected

  def not_authenticated
    redirect_to root_path, alert: 'ログインしてください'
  end
end
