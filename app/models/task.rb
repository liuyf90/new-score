class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :type

  enum status: { 未受理: 0, 已受理: 1, 已完成: 2, 已取消: -1}
  validates :name, :status, presence: true
  # 设置 status 字段的默认值为 0
  attribute :status, :integer, default: 0

  def do_next_step
     # 使用 enum 中的值来自增状态
    if 已受理?
      self.已完成!
    elsif 未受理?
      self.已受理!
    end
    save
  end

  def cancel
    self.已取消!
    save
  end
end
