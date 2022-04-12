module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ログアウトの処理（一時的セッションの破棄）　セッションからユーザーIDを削除。また@current_userに代入されたユーザーオブジェクトを破棄。
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # 現在ログイン中のユーザーがいればtrue,そうでなければfaulseを返す。
  def logged_in?
    !current_user.nil?
  end
end
