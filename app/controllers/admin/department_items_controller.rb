class Admin::DepartmentItemsController < AdminController
  def index
    @department = Department.find(params[:id])
    @department_items = @department.items
  end
end