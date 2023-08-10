require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "project attributes is not null" do
    project = Project.new
    assert project.invalid?
    assert project.errors[:name].any?
    assert project.errors[:amount].any?
    assert project.errors[:sponsor].any?
  end

  test "project amount is number" do
    project = Project.new(name: "绥化城管",  sponsor: "张三")
    project.amount = "abc"
    assert project.invalid?
    assert_equal ["is not a number"],project.errors[:amount] #  project.amount = -1
    
    project.amount = -1
    assert project.invalid?
    assert_equal project.errors[:amount], ["must be greater than or equal to 0.01"]

    project.amount = 0
    assert project.invalid?
    assert_equal project.errors[:amount], ["must be greater than or equal to 0.01"]

    project.amount = 1
    assert project.valid?

  end
end
