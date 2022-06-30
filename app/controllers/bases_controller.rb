class BasesController < ApplicationController
  
  def index
    @bases = Base.all
  end
  
  def new
    @base = Base.new
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点情報作成しました。"
      redirect_to bases_path
    else
      render :new
    end
  end
  
  def edit
    @base = Base.find(params[:id])
  end
  
  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "更新に成功しました。"
      redirect_to bases_url
    else
      @bases = Base.all
      render :index
      flash[:danger] = "更新に失敗しました。"
      redirect_to users_url @user
    end
  end
  
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    flash[:success] = "拠点番号#{@base.base_number}、拠点名「#{@base.base_name}」を削除しました。"
    redirect_to bases_path
  end
  
  private
    def base_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end
end
