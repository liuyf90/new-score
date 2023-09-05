class TypesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    load_and_authorize_resource
    def index
        @types = Type.page(params[:page]).per(5)
    end

    def new
        @type = Type.new
        authorize! :manage, @user # 使用 @user 进行权限检查
    end

    def create
        @type = Type.new(type_params)
        if @type.save
            redirect_to types_url,notice: "新增类型成功!"
        else
            render :new,status: :unprocessable_entity
        end
    end

    def edit
        @type = Type.find_by(id: params[:id])
    end

    def update
        @type = Type.find_by(id: params[:id])
        Rails.logger.debug("show the type's params: #{params.inspect}")
        if @type.update(type_params)
            # 成功
            redirect_to types_path, notice: "更新成功!"
        else
            # 失敗
            render :edit,status: :unprocessable_entity
        end
    end

    private

    def type_params
        params.require(:type).permit(:name, :point_factor)
    end
end
