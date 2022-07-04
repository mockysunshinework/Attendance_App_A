class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:show, :edit, :update, :index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  # before_action :correct_user_or_admin_user ,only: :show
  before_action :set_one_month, only: :show

  def new
    @user = User.new
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def index
    @users = User.search(params[:search]).paginate(page: params[:page])
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to users_url @user
    else
      @users = User.search(params[:search]).paginate(page: params[:page])
      render :index
      # flash[:danger] = "更新に失敗しました。"
      # redirect_to users_url @user
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_path
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    @users = User.all
    @users.each do |user|
      if user.update_attributes(basic_info_params)
        flash[:success] = "基本情報の更新に成功しました。"
      else
        flash[:danger] = "更新に失敗しました。<br>" + @user.errors.full_messages.join("<br>")
      end
    end
    redirect_to user_path(current_user)
  end

  def go_work
    @users = User.all.includes(:attendances)
  end

  def import
    if params[:file].blank?
      flash[:danger] = "読み込むCSVファイルを選択して下さい。"
      redirect_to users_url
    elsif File.extname(params[:file].original_filename) != ".csv"
      flash[:danger] = "CSVファイルのみ読み込み可能です。"
      redirect_to users_url
    else
      if User.all.include?(params[:file])
        flash[:success] = "登録済みユーザーがいます。"
      　redirect_to users_url
      else
      User.import(params[:file])
        flash[:success] = "ユーザーをインポートしました。"
        redirect_to users_url
      end
    end
  end
  
  # def import
    # result = User.import(params[:file])
    # f_message = User.import_result(result)
    # flash[f_message[:status]] = f_message[:message]
    # redirect_to users_url
  # end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :department, :password,
                                   :password_confirmation, :employee_number, 
                                   :uid, :basic_work_time, :designated_work_start_time,
                                   :designated_work_end_time)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
    
    
end

