class BasesController < ApplicationController
  
  def index
  end
  
  def new
    @base = Base.new
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      # 保存が成功した時の処理
    else
      render :new
    end
  end
  
  private
    def base_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end
end
