module SessionsHelper
  def current_user
    # current_userにインスタンスが存在すれば何もしない。
    # インスタンスが存在しなければ、値を代入。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    # ログインしていればtrue、ログインしていないとfalseを返す。
    !!current_user
  end
end