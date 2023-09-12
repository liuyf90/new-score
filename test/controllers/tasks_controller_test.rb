require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  setup do
    @task = tasks(:one)
    @task2 = tasks(:two)
    @user = users(:one)
    sign_in @user
  end
  # test "the truth" do
  #   assert true
  # end
  # test "do next step"

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

end
