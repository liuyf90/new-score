class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :type

  enum status: { 未受理: 0, 已受理: 1, 已完成: 2, 已取消: -1}
  validates :name, :status, presence: true
  # 设置 status 字段的默认值为 0
  attribute :status, :integer, default: 0



  before_update :create_accounting_book_if_needed



  def totle_score
    # byebug
    AccountingBook.where(task: self, staff: self.user&.staff).sum(:score)
  end

  def do_next_step
     # 使用 enum 中的值来自增状态
    if 已受理?
      self.已完成!
    elsif 未受理?
      self.已受理!
    end
    save
  end

  def do_back_step
     # 使用 enum 中的值来自增状态
    if 已完成?
      self.已受理!
    elsif 已受理?
      self.未受理!
    end
    save
  end

  def cancel
    self.已取消!
    save
  end

  def days_since_created
    (Date.today - created_at.to_date).to_i
  end

  private

  def create_accounting_book_if_needed
    # 获取属性变化的详细信息
    changes = self.status_change
    if changes
      old_status, new_status = changes

      case [old_status, new_status]
      when [Task.statuses[:未受理], Task.statuses[:已受理]], [Task.statuses[:已受理], Task.statuses[:已完成]]
        # byebug
        AccountingBook.create(task: self, staff: self.user.staff, step: self.status, step_name: Task.statuses.key(self.status))
      when [Task.statuses[:已完成], Task.statuses[:已受理]], [Task.statuses[:已受理], Task.statuses[:未受理]]
        #  byebug
        AccountingBook.where(task: self, staff: self.user.staff, step: old_status).destroy_all
      when [Task.statuses[:已完成], Task.statuses[:未受理]]
        AccountingBook.where(task: self, staff: self.user.staff).destroy_all
      end
    end
  end

end
