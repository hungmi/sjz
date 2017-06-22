module DepartmentsHelper
  def department_color(department)
    colors = [
      "table-warning",
      "table-danger",
      "table-info",
      "table-success"
    ]
    return colors[department.id % colors.size]
  end
end