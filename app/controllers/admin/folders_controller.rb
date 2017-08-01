class Admin::FoldersController < AdminController
	def new
		@folder = Folder.new
    render partial: "admin/folders/form", locals: { folder: @folder }	
	end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      render partial: @folder
    else
      render json: @folder.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
		@folder = Folder.find(params[:id])
    render partial: "admin/folders/form", locals: { folder: @folder }	
	end

  def update
  	@folder = Folder.find(params[:id])
    if @folder.update(folder_params)
      render partial: @folder
    else
      render json: @folder.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
  	@folder = Folder.find(params[:id])
  	if @folder.destroy
      render status: :ok
    else
    	respond_to do |format|
      	format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def folder_params
  	params.require(:folder).permit(:name, :parent_id)
  end
end