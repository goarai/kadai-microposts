class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # unless は if の反対です。 if は true のときに処理を実行しますが、 unless は false のときに処理を実行します。
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
