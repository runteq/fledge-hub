class UserDeactivationsController < ApplicationController
  def new
    @deactivated_product_sample = current_user.products.first.clone
    @deactivated_product_sample.user.display_name = '退会済みユーザー'
  end

  def destroy
    current_user.deactivate!
    logout
    redirect_to users_url, notice: '退会処理が完了しました。ありがとうございました。'
  end
end
