class DepartmentItemsController < ApplicationController
  def index
    @department = Department.find(params[:id])
    @department_items = @department.items
  end
end