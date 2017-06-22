# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
["行政部","財務部","市場部"].each do |department_name|
	Department.create(name: department_name)
end

["謝沛廷","吳惠娟"].each do |employee_name|
	Employee.create({
		name: employee_name,
		mobile_phone: "189286289#{rand(10..99)}",
		department_id: 1
	})
end

["蔡穎華","陳玉玲"].each do |employee_name|
	Employee.create({
		name: employee_name,
		mobile_phone: "189286289#{rand(10..99)}",
		department_id: 2
	})
end