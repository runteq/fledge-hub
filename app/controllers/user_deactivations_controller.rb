class UserDeactivationsController < ApplicationController
  def new
    @deactivated_product_sample = current_user.products.first.clone
    return unless @deactivated_product_sample

    @deactivated_product_sample.user.display_name = '退会済みユーザー'
    @deactivated_product_sample.user.status = :deactivated
  end

  def destroy
    current_user.deactivate!
    logout
    redirect_to root_url, notice: '退会処理が完了しました。ありがとうございました。'
  end
end
