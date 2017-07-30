class Admin::ItemsController < AdminController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = Item.order(updated_at: :desc).ransack(params[:q]).result
  end

  def list
    @items = Item.order(updated_at: :desc)
    render partial: @items
  end

  def new
    @item = Item.new
    @departments = Department.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "建立成功"
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def upload
    Item.import_items(params[:item_file])
    flash[:success] = "匯入成功"
    redirect_to admin_items_path
  end

  def show
  end

  def edit
    @departments = Department.all
  end

  def update
    if @item.update(item_params)
      flash[:success] = "更新成功"
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private

    def find_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :spec, :quantity, :unit, :image, :department_id, :employee_id)
    end
end