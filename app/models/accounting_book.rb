class AccountingBook < ApplicationRecord
  belongs_to :task
  belongs_to :staff

  before_save :calculate_score

  # 定义一个自定义的方法来计算 score
  def calculate_score
    # 在这里编写计算 score 的逻辑，例如根据其他字段的值来计算 score
    self.score = cal_score
  end

  private
  def cal_score
    self.score = self.task.type.point_factor * self.task.days_since_created
  end

end
