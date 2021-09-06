class ApplicationController < ActionController::Base
  include Pagy::Backend

  protected

  def not_authenticated
    redirect_to root_path, alert: 'ログインしてください'
  end
end
