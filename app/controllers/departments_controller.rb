class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order(ordering: :asc, id: :asc)
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(department_params)
    flash[:success] = "建立成功"
    redirect_to departments_path
  end

  def edit
    @department = Department.find(params[:id])
    render partial: "/departments/form", locals: { department: @department }
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      render partial: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :ordering)
  end
end