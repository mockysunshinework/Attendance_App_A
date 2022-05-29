module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 永続的セッションを記憶する。
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 永続的セッションを破棄する。
  def forget(user)
    user.forget #Userモデルを参照。
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # ログアウトの処理（一時的セッションの破棄）　セッションからユーザーIDを削除。また@current_userに代入されたユーザーオブジェクトを破棄。
  # 7.1.4で24行目を追加（セッションと＠current_userを破棄します）
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
    # 32-35行のコードは勤怠チュートリアル7.1.3で上記21−30を定義する前のcurrent＿user。消さないで記載している。
    # if session[:user_id]
      # @current_user ||= User.find_by(id: session[:user_id])
    # end
  # end
  
  # 渡されたユーザーがログイン済みのユーザーであればtrueを返す。
  def current_user?(user)
    user == current_user
  end
  
  # 現在ログイン中のユーザーがいればtrue,そうでなければfalseを返す。
  def logged_in?
    !current_user.nil?
  end
  
  # 管理権限あるならtrue,そうでなければfalseを返す。
  def admin_user?
    current_user.admin?
  end
  
  # 記憶しているURL(またはデフォルトURL)にリダイレクトします。
  def redirect_back_or(default_url)
    redirect_to(session[:forwarding_url] || default_url)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを記憶します。
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
