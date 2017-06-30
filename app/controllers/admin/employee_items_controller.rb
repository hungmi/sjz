class Admin::EmployeeItemsController < AdminController
  def index
    @employee = Employee.find(params[:id])
    @employee_items = @employee.items
  end
end