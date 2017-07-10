class Admin::DocsController < AdminController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]
  def index
    @docs = Doc.normal.order(updated_at: :desc, name: :asc).ransack(params[:q]).result
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params)
    if @doc.save
      flash[:success] = "建立成功"
      if @doc.normal?
        redirect_to admin_docs_path
      else
        redirect_to admin_iso_docs_path
      end
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @doc.update(doc_params)
      flash[:success] = "更新成功"
      if @doc.normal?
        redirect_to admin_docs_path
      else
        redirect_to admin_iso_docs_path
      end
    else
      render :edit
    end
  end

  def destroy
    if @doc.destroy(doc_params)
      flash[:success] = "刪除成功"
    else
      flash[:failed] = "刪除失敗"
    end
    if @doc.normal?
      redirect_to admin_docs_path
    else
      redirect_to admin_iso_docs_path
    end
  end

  private

    def find_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:name, :code, :description, :note, :iso)
    end
end