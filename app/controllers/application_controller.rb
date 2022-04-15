class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 全コントローラーの親クラスであるapplication_controller.rbにこのモジュールを
  # 読み込ませることでどのコントローラーでもヘルバーに定義したメソッドが使えるようになる。
  # 勤怠チュートリアル６章参照。
  include SessionsHelper
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
end
