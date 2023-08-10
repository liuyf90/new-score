class Project < ApplicationRecord
    #project attibutes not are null
    validates :name, :amount, :sponsor, presence: true
    #amount is number
    validates :amount, numericality: {greater_than_or_equal_to: 0.01}
end
