require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  setup do
    @task = tasks(:task1_user1_admin)
    @task2 = tasks(:task2_user2_user)
    @admin = users(:user1_admin)
    @user = users(:user2_user)
    sign_in @admin
  end

  test "should update task status" do
    #from 0（未受理） to 1（已受理）
    assert_difference('@task.reload.status', 1) do
      patch do_next_step_task_url(@task)
    end
    assert_difference('@task2.reload.status', 1) do
      patch do_next_step_task_url(@task2)
    end

    assert_redirected_to tasks_url
  end

  test "user only show self's tasks" do

    # 计算任务的总数
    total_task_count = Task.count
    # 登录用户2
    sign_out @admin 
    sign_in @user
    @user.staff = Staff.second
   
    # 尝试访问其他用户user1的任务
    get tasks_url
     # 断言页面中包含用户2的任务名称
    assert_response :success
    assert_select 'table tbody tr', count: @user.tasks.count
    assert_select 'table tbody tr td', text: @user.tasks.first.name
  end

 # test "admin should show all tasks" do
 #   total_task_count = Task.count
 #   @admin.staff = Staff.first
 #   get tasks_url
 #   assert_response :success
 #   assert_select 'table tbody tr', count: total_task_count
 # end

  test "don't update other owner's task unless admin" do
    # 用户1是管理员
    @admin.staff = Staff.first 
    # 尝试访问其他用户user2的任务
    patch do_next_step_task_url(@task2)
    assert_redirected_to tasks_url
    assert_equal "操作成功!", flash[:notice]
    # 登录用户2
    sign_out @admin 
    sign_in @user
    @user.staff = Staff.second
    # 尝试访问其他用户user1的任务
    patch do_next_step_task_url(@task)
    assert_redirected_to tasks_url
    assert_equal "无权操作其他人的任务!", flash[:notice]
  end

  test "calculate task score on today" do
    # 新增一个任务,系数是1.5,当天的任务
    @admin.staff = Staff.first 
    task = Task.new(name: '测试任务', descript: '测试任务', status: 0, project: Project.first, user: @admin, type: types(:test))
    task.save 
    assert task.valid?
    patch do_next_step_task_url(task)
    assert_equal 1*types(:test).point_factor, task.totle_score
  end

  test "Calculate task score when it has been more than 1 day" do
    #新增一个昨天的任务
    @admin.staff = Staff.first 
    task = Task.new(name: '测试任务', descript: '测试任务', created_at:Date.yesterday,  status: 0, project: Project.first, user: @admin, type: types(:test))
    task.save
    assert task.valid?
    patch do_next_step_task_path(task)
    assert_equal 2*types(:test).point_factor, task.totle_score
  end
end
