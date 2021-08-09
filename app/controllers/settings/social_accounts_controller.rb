module Settings
  class SocialAccountsController < ApplicationController
    def index
      social_accounts_hash = current_user.social_accounts.index_by(&:social_service_id)
      @social_accounts = all_social_accounts(current_user, social_accounts_hash)
    end

    def upsert_all
      social_account_form = SocialAccountForm.new(social_accounts_params)
      social_account_form.save

      redirect_to settings_social_accounts_path, notice: '外部アカウントの情報を更新しました！'
    end

    private

    def social_accounts_params
      params
        .require(:user)
        .permit(social_accounts_attributes: %i[social_service_id identifier])
        .merge(user: current_user)
    end

    def all_social_accounts(user, social_accounts_hash)
      SocialService.asc.map do |social_service|
        social_accounts_hash[social_service.id] ||
          user.social_accounts.new(social_service_id: social_service.id)
      end
    end
  end
end
