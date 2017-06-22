class Department < ApplicationRecord
  has_many :employees
  has_many :items

  validates :name, presence: true
end
