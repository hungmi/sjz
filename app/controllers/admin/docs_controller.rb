class Admin::DocsController < AdminController
  before_action :find_doc, only: [:download, :show, :edit, :update, :destroy]

  def download
    url = OssService.new.download_url @doc.oss_name
    if url.present?
      redirect_to url
    else
      flash[:danger] = "發生錯誤，請稍候再試。"
      redirect_back fallback_location: @doc.index_url
    end
  end

  def index
    @docs = Doc.normal.order(updated_at: :desc, name: :asc).ransack(params[:q]).result
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params.merge({name: params[:file].original_filename}))
    if @doc.save
      OssService.new.upload(params[:file], @doc.oss_name)
      flash[:success] = "建立成功"
      redirect_to @doc.index_url
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
      redirect_to @doc.index_url
    else
      render :edit
    end
  end

  def destroy
    if @doc.destroy(doc_params)
      flash[:success] = "刪除成功"
    else
      flash[:danger] = "刪除失敗"
    end
    redirect_back fallback_location: @doc.index_url
  end

  private

    def find_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:name, :code, :description, :note, :iso, :oss_key)
    end
end