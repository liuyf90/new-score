class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  enum status: { 未受理: 0, 已受理: 1, 已完成: 2, 已取消: 3 }
  validates :name , presence: true 
    # 设置 status 字段的默认值为 0
  attribute :status, :integer, default: 0
end
