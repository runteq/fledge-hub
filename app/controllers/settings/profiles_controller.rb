module Settings
  class ProfilesController < ApplicationController
    def show
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to settings_profile_path, notice: 'ユーザー情報を更新しました！'
      else
        render :show, status: :unprocessable_entity # 422errorを起こす
      end
    end

    private

    def user_params
      params.require(:user).permit(:display_name, :email, :avatar, :study_started_on)
    end
  end
end
