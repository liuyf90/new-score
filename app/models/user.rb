class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :staff
  has_many :users_roles
  has_many :roles, through: :users_roles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  accepts_nested_attributes_for :staff

end
