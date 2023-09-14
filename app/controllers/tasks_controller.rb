class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  load_and_authorize_resource
  def index
    if can?(:manage, Task)
      @tasks = Task.page(params[:page]).per(5)
    else
      @tasks = Task.where(user: current_user).or(Task.where(user_id: nil)).page(params[:page]).per(5)
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    Rails.logger.debug("show the task's params: #{params.inspect}")
    if @task.update(task_params)
      # 成功
      redirect_to tasks_path, notice: '更新成功!'
    else
      # 失敗
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @task = Task.new
    # authorize! :manage, @task.user # 使用 @task.user 进行权限检查
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: '新增任务成功!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def pickup_tasks
  end

  def available_list
      @available_tasks = Task.where(user_id: nil).page(params[:page]).per(5)
  end
  # enum status: { 未受理: 0, 已受理: 1, 已完成: 2, 已取消: 3 }
  def do_next_step
    @task = Task.find_by(id: params[:id])
    # byebug
    if @task && (@task.user_id == current_user.id || can?(:manage, @task) || @task.user_id == nil) # 检查用户是否具有执行 do_step_next 的权限
      # byebug # 或 binding.pry
      @task.user_id = current_user.id
      @task.do_next_step # 尝试更新任务状态
      if @task.save # 如果保存成功
        redirect_to tasks_url, notice: '操作成功!'
      else
        # 处理保存失败的情况
        redirect_to tasks_url, notice: '操作失败!'
      end
    else
      # 处理找不到任务的情况
       redirect_to tasks_url, notice: '无权操作其他人的任务!'
    end
  end

  def do_back_step
    @task = Task.find_by(id: params[:id])
    if @task
      # byebug # 或 binding.pry
      @task.user_id = current_user.id
      @task.do_back_step # 尝试更新任务状态
      if @task.save # 如果保存成功
        redirect_to tasks_url, notice: '操作成功!'
      else
        # 处理保存失败的情况
        render :new, status: :unprocessable_entity
      end
    else
      # 处理找不到任务的情况
      render :not_found, status: :not_found
    end
  end

  def cancel # Ex:- change_column("admin_users", "email", :string, :limit =>25)
    @task = Task.find_by(id: params[:id])
    if @task
      # byebug # 或 binding.pry
      @task.cancel # 尝试更新任务状态
      if @task.save # 如果保存成功
        redirect_to tasks_url, notice: '操作成功!'
      else
        # 处理保存失败的情况
        render :new, status: :unprocessable_entity
      end
    else
      # 处理找不到任务的情况
      render :not_found, status: :not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :user_id, :project_id, :type_id)
  end
end
