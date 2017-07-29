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
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  private

  def folder_params
  	params.require(:folder).permit(:name, :parent_id)
  end
end