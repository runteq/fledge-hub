class ProfilesController < ApplicationController
  before_action :require_login

  def show; end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.screen_name), notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity # 422errorを起こす
    end
  end

  def destroy
    current_user.deactivate!
    redirect_to users_url, notice: '退会しました'
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :email)
  end
end
