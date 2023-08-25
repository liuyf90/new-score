class StaffsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
load_and_authorize_resource
  def index
    @staffs = Staff.page(params[:page]).per(5)
  end

  def show
    @staff = Staff.find_by(id: params[:id])
    authorize! :read, @user
  end

  def new
    @staff = Staff.new
    authorize! :manage, @user

  end

  def edit
    @staff = Staff.find_by(id: params[:id])
  end

  def create
    @staff = Staff.new(staff_params)
    authorize! :manage, @user
    if @staff.save
      redirect_to staffs_url,notice: "新增员工成功!"
    else
      render :new,status: :unprocessable_entity
    end
  end 

  def update
    @staff = Staff.find_by(id: params[:id])
    Rails.logger.debug("show the staff's params: #{params.inspect}")
    if @staff.update(staff_params)
      # 成功
      redirect_to staffs_path, notice: "更新成功!"
    else
      # 失敗
      render :edit,status: :unprocessable_entity
    end
  end
  
  def enable
    staff = Staff.find_by(id: params[:id])
    staff.update(status: 1)
    redirect_to staffs_path, notice: "#{staff.name}已启用"
  end
  def disable
    staff = Staff.find_by(id: params[:id])
    staff.update(status: 0)
    redirect_to staffs_path, notice: "#{staff.name}已停用"
  end

  private
  def staff_params
    params.require(:staff).permit(:name, :status, :mobile, :user_id)

  end
  def record_not_found
     logger.error("记录不存在 #{params[:id]}")
     redirect_to staff_path, notice: "记录不存在"
  end
end

