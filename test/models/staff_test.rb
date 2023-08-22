require "test_helper"

class StaffTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   #fixtures :staffs, :projects  # 确保正确加载 staffs.yml 和 projects.yml
   test "staff attributes is not null" do
      staff = Staff.new
      assert staff.invalid?
      assert staff.errors[:name].any?
      assert staff.errors[:mobile].any?
   end

   test "incorrect mobile number" do
      staff = Staff.new(name: "张三", status: 1, mobile: "123",user_id: 1)
      assert staff.invalid?
      assert staff.errors[:mobile].any?

      staff = Staff.new(name: "张三", status: 1, mobile: "12312312312345", user_id:1)
      assert staff.invalid?
      assert staff.errors[:mobile].any?

   end
end
