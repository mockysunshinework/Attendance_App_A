class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 全コントローラーの親クラスであるapplication_controller.rbにこのモジュールを
  # 読み込ませることでどのコントローラーでもヘルバーに定義したメソッドが使えるようになる。
  # 勤怠チュートリアル６章参照。
  include SessionsHelper
end
