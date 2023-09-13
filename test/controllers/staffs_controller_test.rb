require "test_helper"

class StaffsControllerTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers # Rails >= 5
  setup do
    @staff = staffs(:user1_admin_staff)
    @update = {
      name: "王五",
      mobile: 15645101471,
      status: :在用,
    }
    @user = users(:user1_admin)
    sign_in @user
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

  test "should to update staff" do
    patch staff_url(@staff), params: { staff: @update }
    assert_redirected_to staffs_url()
  end


#  test "should create staff" do
#    assert_difference('Staff.count') do
#      post staffs_url, params: { staff: @staff}
#    end
#    assert_redirected_to staffs_url
#  end

end
