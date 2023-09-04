class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  load_and_authorize_resource
  def index
    @tasks = Task.page(params[:page]).per(5)
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    Rails.logger.debug("show the task's params: #{params.inspect}")
    if @task.update(task_params)
      # 成功
      redirect_to tasks_path, notice: "更新成功!"
    else
      # 失敗
      render :edit,status: :unprocessable_entity
    end
  end

  def new
    @task = Task.new
    #authorize! :manage, @task.user # 使用 @task.user 进行权限检查
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url,notice: "新增任务成功!"
    else
      render :new,status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :user_id , :project_id)
  end
end
