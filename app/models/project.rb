class Project < ApplicationRecord
    #name not is null
    validates :name, presence: true
end
