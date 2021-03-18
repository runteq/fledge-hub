class ApplicationController < ActionController::Base
  protected

  def not_authenticated
    redirect_to root_path
  end
end
