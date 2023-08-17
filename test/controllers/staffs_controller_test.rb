require "test_helper"

class StaffsControllerTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers # Rails >= 5
  setup do
    @staff = staffs(:one)
    @update = {
      name: "王五",
      mobile: 15645101471,
      status: :在用,
      password: "secret",
      password_confirmation: "secret"
    }
  end
  
  #fixtures :staffs, :projects
  test "should get index" do
    get staffs_url
    assert_response :success
  end
  
  test "should get new" do
    get new_staff_url
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post staffs_url, params: { staff: @update }
    end
    assert_redirected_to staffs_url
  end

  test "should update project" do
     patch staff_url(@staff), params: { staff: @update }
     assert_redirected_to staffs_url()
  end
end
