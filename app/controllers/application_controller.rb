class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 全コントローラーの親クラスであるapplication_controller.rbにこのモジュールを
  # 読み込ませることでどのコントローラーでもヘルバーに定義したメソッドが使えるようになる。
  # 勤怠チュートリアル６章参照。
  include SessionsHelper
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
  def set_user
    @user = User.find(params[:id])
  end
    
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end
    
  def correct_user
    unless current_user?(@user)
      flash[:danger] = "アクセスできません。"
      redirect_to root_url 
    end
  end
    
  def admin_user
    unless current_user.admin?
      redirect_to root_url
    end
  end
  
  def correct_user_or_admin_user
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "やり直して下さい"
      redirect_to root_url
    end
  end
  
  # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
  def set_one_month 
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]

    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)

    unless one_month.count == @attendances.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.attendances.create!(worked_on: day) }
      end
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    end

  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
end
