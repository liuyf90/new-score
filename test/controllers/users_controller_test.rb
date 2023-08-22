require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
    @staff = staffs(:one)
  end
end
