class Staff < ApplicationRecord
    has_many :projects
    enum status: {"在用": 1, "停用": 0}
    validates :name, :mobile, :status,  presence: true 
    validates :name, uniqueness: true
    validates :mobile, format: { with: /\A1[3-9]\d{9}\Z/,
        message: "only allows phone number" }
end
