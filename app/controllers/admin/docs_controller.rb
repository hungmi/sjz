class Admin::DocsController < AdminController
  before_action :find_doc, only: [:share, :preview, :download, :show, :edit, :update, :destroy]
  before_action :find_folder, only: [:index, :new, :create, :edit, :update]

  def share
    url = @doc.download_url params[:share_timeout]
    if url.present?
      redirect_to url
    else
      flash[:danger] = "發生錯誤，請稍候再試。"
      redirect_back fallback_location: @doc.index_url
    end
  end

  def preview
    url = @doc.preview_url
    if url.present?
      redirect_to url
    else
      flash[:danger] = "發生錯誤，請稍候再試。"
      redirect_back fallback_location: @doc.index_url
    end
  end

  def download
    url = @doc.download_url
    if url.present?
      redirect_to url
    else
      flash[:danger] = "發生錯誤，請稍候再試。"
      redirect_back fallback_location: @doc.index_url
    end
  end

  def index
    @docs = @folder.docs.order(updated_at: :desc, name: :asc).ransack(params[:q]).result
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params.merge({name: params[:file].try(:original_filename)}))
    if @doc.save
      if OssService.new.upload(params[:file], @doc.generate_oss_name)
        @doc.update_column(:oss_key, @doc.generate_oss_name)
      end
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

    def find_folder
      @folder = Folder.find(params[:folder_id])
    end

    def find_doc
      @doc = Doc.find(params[:id])
    end

    def find_doc_by_oss_name
      @doc = Doc.find_by_oss_name(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:name, :folder_id, :code, :description, :note, :iso, :oss_key)
    end
end