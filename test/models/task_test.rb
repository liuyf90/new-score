require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    # 在测试开始前的设置代码
    @task = Task.new(name: '测试任务', project_id: 1, user_id: 1, status: 0)

    project = Project.first
    user = User.first
    type = Type.first

    @task.project = project
    @task.user = user

    @task.type = type
  end

  test 'task name is not null' do
    task = Task.new
    assert task.invalid?
    assert task.errors[:name].any?
  end

  test 'task user can be null' do
    task = Task.new(name: '测试任务', status: 0)
    project= Project.first
    type = Type.first
    task.project = project
    task.type = type
    task.save
    assert task.valid?
  end

  test 'save a task' do
    @task.save
    assert @task.valid?
  end

  test 'change task status from 0 to 1 and from 1 to 0' do
    @task.save
    assert_equal 0, @task.status
    assert_difference('AccountingBook.count', 1) do
      @task.do_next_step
    end
    assert_difference('AccountingBook.count', -1) do
      @task.do_back_step
    end
  end

  test 'task status  is updated to 0' do
    @task.save
    assert_equal 0, @task.status
    #从已受理 修改为 未受理
    assert_difference('AccountingBook.count', 1) do
        @task.do_next_step
    end
    assert_equal 1, @task.status
    assert_difference('AccountingBook.count', -1) do
      @task.status = 0
      @task.save
    end
    #从已完成 直接修改为 未受理
    assert_difference('AccountingBook.count', 2) do
      2.times do
        @task.do_next_step
      end
    end
    assert_equal 2, @task.status
    assert_difference('AccountingBook.count', -2) do
      @task.status = 0
      @task.save
    end


  end
end
