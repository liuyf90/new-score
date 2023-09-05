require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "task attributes is not null" do
      task = Task.new
      assert task.invalid?
      assert task.errors[:name].any?
  end
  
  test "save a task" do
    task = Task.new(name: "测试任务", project_id: 1, user_id: 1, status: 0)
   
    project = Project.first
    user = User.first
    type = Type.first
    
    task.project = project
    task.user = user

    task.type = type

    
    task.save
    assert task.valid?


    
  end

end
