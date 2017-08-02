class Admin::SearchController < AdminController
  def index
    @docs = Doc.where(child: nil).ransack({
    	name_cont: params[:q]
    }).result(distinct: true)

    @folders = Folder.ransack({
    	name_cont: params[:q]
    }).result(distinct: true)

    @items = Item.ransack({
    	name_or_spec_or_department_name_or_employee_name_cont: params[:q]
    }).result(distinct: true)

    @employees = Employee.ransack({
    	name_or_mobile_phone_or_department_name_cont: params[:q]
    }).result(distinct: true)
  end
end