require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "save user with staff" do
    user = User.new(email: "test@124.com ", password: "123456")


    staff= user.build_staff(name: "张三", status: :在用, mobile: "15645101471")
    
    user.save
    assert user.valid?
    assert staff.valid?


    assert_equal user.staff.name, "张三"
    assert_equal user.email, "test@124.com"
    
  end
end
