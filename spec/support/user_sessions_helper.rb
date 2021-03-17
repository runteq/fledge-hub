module UserSessionsHelper
  def login_as(user)
    get "/login_as/#{user.id}"
    expect(logged_in?).to be_truthy
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
