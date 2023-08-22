class Staff < ApplicationRecord
    has_many :projects
    belongs_to :user
    
    enum status: {在用: 1, 停用: 0}
    # 设置 status 字段的默认值为 0
    attribute :status, :integer, default: 0
    validates :name, :mobile, presence: true 
    #validates :name, uniqueness: true
    validates :mobile, format: { with: /\A1[3-9]\d{9}\Z/,
        message: "only allows phone number" }

end
