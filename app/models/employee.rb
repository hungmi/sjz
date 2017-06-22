class Employee < ApplicationRecord
  include EmployeesImporter

  belongs_to :department
  has_many :items

  validates :name, presence: true
end
