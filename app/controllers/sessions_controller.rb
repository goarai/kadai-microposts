class SessionsController < ApplicationController
  def new
  end

  def create
    # _vは_valueの意味
    email_v = params[:session][:email].downcase
    password_v = params[:session][:password]
    if login(email_v, password_v)
      flash[:success] = 'ログインに成功しました。'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private
    def login(email, password)
      @user = User.find_by(email: email)
      if @user && @user.authenticate(password)
        # ログイン成功
        session[:user_id] = @user.id
        return true
      else
        # ログイン失敗
        return false
      end
    end
end
