class BasesController < ApplicationController
  
  def index
    @base = Base.new
  end
  
  def new
    @base = Base.new
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      redirect_to bases_path
    else
      render :new
    end
  end
  
  private
    def base_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end
end
