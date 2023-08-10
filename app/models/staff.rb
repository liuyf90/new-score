class Staff < ApplicationRecord
    enum status: {"在用": 1, "停用": 0}
    validates :name, :mobile, presence: true 
end
