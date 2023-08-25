class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, alert: "Access denied."
    end

  # 在每个请求前先进行用户认证
  before_action :authenticate_user!

  # 调用 load_ability 方法来加载权限实例
  before_action :load_ability
  # 加载权限实例
  def load_ability
    @current_ability = Ability.new(current_user)
  end

end
