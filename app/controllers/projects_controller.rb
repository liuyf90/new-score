class ProjectsController < ApplicationController
  def index
    @projects = Project.page(params[:page]).per(5)
    @page_title="项目列表"
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  def new
    @project = Project.new

  end

  def edit
    @project = Project.find_by(id: params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_url,notice: "新增项目成功!"
    else
      render :new,status: :unprocessable_entity
    end
  end 

  def update
    @project = Project.find_by(id: params[:id])

    if @project.update(project_params)
      # 成功
      redirect_to projects_path, notice: "資料更新成功!"
    else
      # 失敗
      render :edit,status: :unprocessable_entity
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :amount, :sponsor)
  end
end
