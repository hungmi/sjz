class Admin::EmployeesController < AdminController
  def index
    # @employee = Employee.new
    # @departments = Department.all
    @employees = Employee.includes(:department).order("departments.ordering asc, employees.id asc")
  end

  def list
    @employees = Employee.order(:department_id, :id)
    render partial: @employees
  end

  def new
    @departments = Department.all
    @employee = Employee.new
  end

  def create
    @employee = Employee.create(employee_params)
    flash[:success] = "建立成功"
    redirect_to admin_employees_path
  end

  def edit
    @departments = Department.all
    @employee = Employee.find(params[:id])
    # form = render_to_string partial: "/employees/form", locals: { employee: @employee }
    # render json: form
    render partial: "admin/employees/form", locals: { employee: @employee }
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      render partial: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def upload
    Employee.import_employees(params[:employee_file])
    flash[:success] = "匯入成功"
    redirect_to employees_path
  end

  private

  def employee_params
    params.require(:employee).permit(:title, :name, :mobile_phone, :tel, :ext, :department_id)
  end
end