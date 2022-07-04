class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    debugger
    # ユーザーオブジェクトを取得
    user = User.find_by(email: params[:session][:email].downcase) 
    # ユーザーオブジェクトを取得でき、かつパスワードも一致した場合の判定はtrue
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報にリダイレクトする。
      log_in user
      params[:session][:remember_me] == '1' ? remember(user):forget(user)
      redirect_back_or user
    else
      # ここにエラーメッセージ用のflashをいれる。
      flash.now[:danger]= "ログインできませんでした。"
    render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトできました。"
    redirect_to root_url
  end
  
end
