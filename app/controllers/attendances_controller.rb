class AttendancesController < ApplicationController
  
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current)
        flash[:success] = "おはようございます！"
      else
        flash[:danger] = "やり直して下さい。"
      end
    end
    redirect_to user_url @user
  end
end
