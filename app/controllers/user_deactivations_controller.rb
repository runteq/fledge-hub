class UserDeactivationsController < ApplicationController
  def new; end

  def destroy
    current_user.deactivate!
    redirect_to users_url, notice: '退会しました'
  end
end
