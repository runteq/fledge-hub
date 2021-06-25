module Settings
  class SocialAccountsController < ApplicationController
    def index
      @user = current_user
      social_accounts_hash = @user.social_accounts.index_by(&:social_service_id)
      @social_accounts = all_social_accounts(@user, social_accounts_hash)
    end

    def update_all
      @user = current_user
      if @user.update(user_params)
        redirect_to settings_profile_path, notice: 'ユーザー情報を更新しました！'
      else
        render :show, status: :unprocessable_entity # 422errorを起こす
      end
    end

    private

    def user_params
      params.require(:user).permit(:display_name, :email)
    end

    def all_social_accounts(user, social_accounts_hash)
      SocialService.all.map do |social_service|
        social_accounts_hash[social_service.id] || user.social_accounts.new(social_service_id: social_service.id)
      end
    end
  end
end
