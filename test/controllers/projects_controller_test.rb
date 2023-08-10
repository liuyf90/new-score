require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
    @update = {
      name: '绥化城管',
      amount: 899.99,
      sponsor: '张三'
    }
  end
  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
      assert_difference('Project.count') do
        post projects_url, params: { project: @update }
      end
      assert_redirected_to projects_url
  end

  test "should update project" do
    patch project_url(@project), params: { project: @update }
    assert_redirected_to projects_url()
  end
end
