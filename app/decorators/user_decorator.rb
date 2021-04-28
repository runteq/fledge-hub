class UserDecorator < Draper::Decorator
  delegate_all

  def github_user_name
    object.display_name.present? ? object.display_name : object.screen_name
  end
end

