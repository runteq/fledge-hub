class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :prepare_exception_notifier

  protected

  def not_authenticated
    redirect_to root_path, alert: 'ログインしてください'
  end

  def prepare_exception_notifier
    return unless current_user

    request.env['exception_notifier.exception_data'] = {
      current_user: user_url(current_user.screen_name),
    }
  end
end
