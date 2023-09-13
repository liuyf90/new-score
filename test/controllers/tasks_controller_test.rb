require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  setup do
    @task = tasks(:task1_user1_admin)
    @task2 = tasks(:task2_user2_user)
    @admin = users(:user1_admin)
    @admin2 = users(:user2_user)
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
    sign_in @admin2
    @admin2.staff = Staff.second
   
    # 尝试访问其他用户user1的任务
    get tasks_url
     # 断言页面中包含用户2的任务名称
    assert_response :success
    assert_select 'table tbody tr', count: @admin2.tasks.count
    assert_select 'table tbody tr td', text: @admin2.tasks.first.name
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
    sign_in @admin2
    @admin2.staff = Staff.second
    # 尝试访问其他用户user1的任务
    patch do_next_step_task_url(@task)
    assert_redirected_to tasks_url
    assert_equal "无权操作其他人的任务!", flash[:notice]

        
    
  end

end
