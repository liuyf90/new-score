# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    user = User.new if user.nil?
    if user.roles.include?(Role.find_by(name: "admin"))
      can :manage, :all   # 具有管理员角色的用户可以管理所有资源
    elsif user.roles.include?(Role.find_by(name: "user"))
      can :read, Project     # 具有用户角色的用户可以查看 Project 资源
      can :update, Staff, user_id: user.id
      #can :read, Task
      # 添加以下权限规则以允许用户执行 Task 的 do_step_next 方法
      can :update, Task, user_id: user.id
      can :read, Task     # 具有用户角色的用户可以查看 Task 资源
      can :do_next_step, Task
      can :do_back_step, Task
    end
  end
end
