class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # ユーザーオブジェクトを取得
    user = User.find_by(email: params[:session][:email].downcase) 
    # ユーザーオブジェクトを取得でき、かつパスワードも一致した場合の判定はtrue
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報にリダイレクトする。
      log_in user
      redirect_to user
    else
      # ここにエラーメッセージ用のflashをいれる。
      flash.now[:danger]= "ログインできませんでした。"
    render :new
    end
  end
  
end
